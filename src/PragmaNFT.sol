// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/// @title PragmaNFT
/// @notice Minimal, self-contained ERC-721-style NFT contract for the PRAGMA project.
/// @dev Includes ownership, approvals, safe transfers, minting, burning, and metadata URI.
contract PragmaNFT {
    string public name;
    string public symbol;

    uint256 private _nextTokenId = 1;
    uint256 private _totalSupply;

    address public owner;
    string private _baseTokenURI;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    error NotOwner();
    error NotTokenOwner();
    error NotApproved();
    error InvalidAddress();
    error TokenDoesNotExist();
    error TokenAlreadyExists();
    error UnsafeRecipient();
    error TransferFromIncorrectOwner();
    error ApprovalToCurrentOwner();
    error ApprovalCallerNotOwnerNorApproved();
    error BaseURIUpdateUnauthorized();

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event BaseURIUpdated(string previousBaseURI, string newBaseURI);

    constructor(string memory name_, string memory symbol_, string memory baseURI_) {
        if (msg.sender == address(0)) revert InvalidAddress();

        name = name_;
        symbol = symbol_;
        owner = msg.sender;
        _baseTokenURI = baseURI_;

        emit OwnershipTransferred(address(0), msg.sender);
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        if (account == address(0)) revert InvalidAddress();
        return _balances[account];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address tokenOwner = _owners[tokenId];
        if (tokenOwner == address(0)) revert TokenDoesNotExist();
        return tokenOwner;
    }

    function getApproved(uint256 tokenId) public view returns (address) {
        if (_owners[tokenId] == address(0)) revert TokenDoesNotExist();
        return _tokenApprovals[tokenId];
    }

    function isApprovedForAll(address tokenOwner, address operator) external view returns (bool) {
        return _operatorApprovals[tokenOwner][operator];
    }

    function approve(address approved, uint256 tokenId) external {
        address tokenOwner = ownerOf(tokenId);
        if (approved == tokenOwner) revert ApprovalToCurrentOwner();
        if (msg.sender != tokenOwner && !_operatorApprovals[tokenOwner][msg.sender]) {
            revert ApprovalCallerNotOwnerNorApproved();
        }

        _tokenApprovals[tokenId] = approved;
        emit Approval(tokenOwner, approved, tokenId);
    }

    function setApprovalForAll(address operator, bool approved) external {
        if (operator == msg.sender) revert ApprovalToCurrentOwner();
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        address tokenOwner = ownerOf(tokenId);
        if (tokenOwner != from) revert TransferFromIncorrectOwner();
        if (!_isApprovedOrOwner(msg.sender, tokenId)) revert NotApproved();
        if (to == address(0)) revert InvalidAddress();

        _clearApproval(tokenId);
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) external {
        transferFrom(from, to, tokenId);
        if (!_checkOnERC721Received(msg.sender, from, to, tokenId, "")) {
            revert UnsafeRecipient();
        }
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external {
        transferFrom(from, to, tokenId);
        if (!_checkOnERC721Received(msg.sender, from, to, tokenId, data)) {
            revert UnsafeRecipient();
        }
    }

    /// @notice Mint the next sequential token to an address.
    function mint(address to) external onlyOwner returns (uint256 tokenId) {
        if (to == address(0)) revert InvalidAddress();

        tokenId = _nextTokenId++;
        if (_owners[tokenId] != address(0)) revert TokenAlreadyExists();

        _owners[tokenId] = to;
        _balances[to] += 1;
        _totalSupply += 1;

        emit Transfer(address(0), to, tokenId);
    }

    /// @notice Burn an owned or approved token.
    function burn(uint256 tokenId) external {
        address tokenOwner = ownerOf(tokenId);
        if (!_isApprovedOrOwner(msg.sender, tokenId)) revert NotApproved();

        _clearApproval(tokenId);
        _balances[tokenOwner] -= 1;
        _totalSupply -= 1;
        delete _owners[tokenId];

        emit Transfer(tokenOwner, address(0), tokenId);
    }

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        ownerOf(tokenId);
        return string.concat(_baseTokenURI, _toString(tokenId), ".json");
    }

    function setBaseURI(string calldata newBaseURI) external onlyOwner {
        string memory previous = _baseTokenURI;
        _baseTokenURI = newBaseURI;
        emit BaseURIUpdated(previous, newBaseURI);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        if (newOwner == address(0)) revert InvalidAddress();
        address previous = owner;
        owner = newOwner;
        emit OwnershipTransferred(previous, newOwner);
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        address tokenOwner = ownerOf(tokenId);
        return spender == tokenOwner || _tokenApprovals[tokenId] == spender || _operatorApprovals[tokenOwner][spender];
    }

    function _clearApproval(uint256 tokenId) internal {
        if (_tokenApprovals[tokenId] != address(0)) {
            delete _tokenApprovals[tokenId];
        }
    }

    function _checkOnERC721Received(
        address operator,
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) private returns (bool) {
        if (to.code.length == 0) return true;

        (bool success, bytes memory returndata) = to.call(
            abi.encodeWithSelector(
                bytes4(keccak256("onERC721Received(address,address,uint256,bytes)")),
                operator,
                from,
                tokenId,
                data
            )
        );

        if (!success || returndata.length != 32) return false;

        bytes4 retval;
        assembly {
            retval := mload(add(returndata, 32))
        }
        return retval == bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    }

    function _toString(uint256 value) private pure returns (string memory) {
        if (value == 0) return "0";

        uint256 digits;
        uint256 temp = value;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits--;
            buffer[digits] = bytes1(uint8(48 + (value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
