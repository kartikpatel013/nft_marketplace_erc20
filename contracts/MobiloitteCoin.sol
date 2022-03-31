// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MobiloitteCoin is ERC20 {
    constructor(uint256 _supply) ERC20("MobiloitteCoin", "MBC") {
        _mint(msg.sender, _supply * (10 ** decimals()));
    }

}
