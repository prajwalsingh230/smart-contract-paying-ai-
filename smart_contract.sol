// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AIWorkshopPayment {
    address public owner;
    uint256 public costPerAPIHit;
    uint256 public totalHits;

    constructor(uint256 _costPerAPIHit) {
        owner = msg.sender;
        costPerAPIHit = _costPerAPIHit;
    }

    // Called per API hit, requires exact payment
    function payPerHit() external payable {
        require(msg.value == costPerAPIHit, "Incorrect payment");
        totalHits += 1;
        payable(owner).transfer(msg.value);
    }

    // Owner can update cost per hit
    function setCost(uint256 newCost) external {
        require(msg.sender == owner, "Not authorized");
        costPerAPIHit = newCost;
    }
}
