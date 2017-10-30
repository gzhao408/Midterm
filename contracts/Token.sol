pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

contract Token is ERC20Interface {
	function totalSupply() constant returns (uint256 totalSupply)
	function balanceOf(address _owner) constant returns (uint256 balance)
	function transfer(address _to, uint256 _value) returns (bool)
}
