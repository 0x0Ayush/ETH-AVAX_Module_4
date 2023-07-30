// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract DegenToken {
    string public name = "Degen";
    string public symbol = "DGN";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10**uint256(decimals)); // Initial supply: 1,000,000 DGN

    address public owner;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Additional mappings to store available items and their prices
    mapping(uint256 => uint256) public itemPrices;
    mapping(uint256 => uint256) public itemStocks;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event ItemPurchased(address indexed buyer, uint256 itemId, uint256 quantity);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;

        // Initialize the shop with item prices and stocks
        itemPrices[1] = 100; // Item ID 1: Food
        itemPrices[2] = 150; // Item ID 2: Water
        itemPrices[3] = 200; // Item ID 3: Power
        itemPrices[4] = 250; // Item ID 4: Health

        itemStocks[1] = 1000; // Initial stock of Food
        itemStocks[2] = 800;  // Initial stock of Water
        itemStocks[3] = 500;  // Initial stock of Power
        itemStocks[4] = 300;  // Initial stock of Health

        // Allocate the total supply to the contract owner
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Invalid recipient");
        require(value > 0, "Invalid value");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        require(spender != address(0), "Invalid spender");

        allowance[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(from != address(0), "Invalid sender");
        require(to != address(0), "Invalid recipient");
        require(value > 0, "Invalid value");
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }

    function mint(address to, uint256 value) external onlyOwner {
        require(to != address(0), "Invalid recipient");
        require(value > 0, "Invalid value");

        totalSupply += value;
        balanceOf[to] += value;

        emit Mint(to, value);
    }

    function burn(uint256 value) external {
        require(value > 0, "Invalid value");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        totalSupply -= value;

        emit Burn(msg.sender, value);
    }
    function buyItem(uint256 itemId, uint256 quantity) external {
        require(itemId >= 1 && itemId <= 4, "Invalid item ID");
        require(itemPrices[itemId] > 0, "Item not available");
        require(itemStocks[itemId] >= quantity, "Insufficient item stock");
        uint256 totalCost = itemPrices[itemId] * quantity;
        require(balanceOf[msg.sender] >= totalCost, "Insufficient balance");

        // Update the item stock and player's token balance
        itemStocks[itemId] -= quantity;
        balanceOf[msg.sender] -= totalCost;

        emit ItemPurchased(msg.sender, itemId, quantity);
    }
}