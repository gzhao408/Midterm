pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale {
	// YOUR CODE HERE
	address owner;
	uint num_sold;
	uint start_time;
	uint end_time;
	Token token; 
	uint price;

	event SaleOver();
	event TokenPurchase(address buyer, uint amount);
	event TokenRefund(address buyer, uint amount);

	function saleEnded() returns (bool) {
		return now >= end_time;
	}
	
	function Crowdsale(uint end, uint supply, uint price) {
		owner = msg.sender;
		start_time = now;
		end_time = end;
		token = Token {[totalSupply : supply]}
		price = price; 
	}

	function purchase(uint amount) payable {
		TokenPurchase(msg.sender, amount);
	}

	function mint(uint amount) {
		token.totalSupply += amount;
	}

	function burn(uint amount) {
		//something
	}

	function checkTime() {
		if (saleEnded()) {
			SaleOver();
			owner.transfer(self.everything);
		}
	}
}
