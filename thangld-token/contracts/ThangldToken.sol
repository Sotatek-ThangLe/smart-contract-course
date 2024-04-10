// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ThangldToken is ERC20 {
    address public owner;
    address public treasury;
    address public hotWallet;
    mapping(address => bool) private _blacklist;

    uint256 public constant DECIMAL = 1e7; // 10,000,000
    uint256 public constant TAX = 0; // No tax for transfers

    constructor() ERC20("ThangldToken", "GIN") {
        owner = msg.sender;
        _mint(msg.sender, 1000 * DECIMAL);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns (bool) {
        _mint(_to, _amount);
        return true;
    }

    function burn(uint256 _amount) external onlyOwner returns (bool) {
        _burn(msg.sender, _amount);
        return true;
    }

    function addToBlacklist(address _user) external onlyOwner returns (bool) {
        require(!_blacklist[_user], "Address is already on blacklist");
        _blacklist[_user] = true;
        return true;
    }

    function removeFromBlacklist(address _user) external onlyOwner returns (bool) {
        require(_blacklist[_user], "Address is not on blacklist");
        _blacklist[_user] = false;
        return true;
    }

    function updateTreasuryAddress(address _treasury) external onlyOwner returns (bool) {
        require(_treasury != address(0), "Invalid address");
        treasury = _treasury;
        return true;
    }

    function transfer(address _to, uint256 _amount) public override returns (bool) {
        require(!_blacklist[_to], "Receiver is on the blacklist");

        uint256 taxAmount = (_amount * TAX) / 100;
        uint256 remainingAmount = _amount - taxAmount;

        _transfer(msg.sender, treasury, taxAmount);
        _transfer(msg.sender, _to, remainingAmount);

        return true;
    }
}
