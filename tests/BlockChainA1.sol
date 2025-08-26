// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EthPayment {
    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Access denied: only owner");
        _;
    }

    function sendEther(address payable to, uint256 value) external onlyOwner {
        require(address(this).balance >= value, "Not enough balance");
        (bool sent, ) = to.call{value: value}("");
        require(sent, "ETH transfer failed");
    }

    // Function to check contract balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // Fallback to accept ETH
    receive() external payable {}
}
