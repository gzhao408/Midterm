pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
	uint8 size = 5;
	uint8 front;
	uint8 back;
	Buyer[] buyers;
	uint timelimit = 100;

	struct Buyer {
		address address;
		uint timer; //when you construct a buyer you set their timer and then it runs to 0
	}

	function Buyer(address a, uint t) {
		address = a;
		timer = t;
	}

	/* Add events */
	event ejected(address buyer);

	/* Add constructor */
	function Queue () {
		front = 0;
		back = 0;
		buyers = Buyer[size];

	}

	/* Returns the number of people waiting in line */
	function qsize() constant returns(uint8) {
		return (back - front + 1) % size;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		return back == front;
	}
	
	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
		return buyers[front % size];
	}
	
	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() constant returns(uint8) {
		int position = -1;
		for (int i = 0; i < size; i++) {
			if (buyers[i] == msg.sender) return (i - front) % size;
		}
		return position;
	}
	
	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
		Buyer first = buyers[front % size];
		if (first.timer == 0) {
			ejected(first.address);
			dequeue();
		}
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() {
		if(empty()) revert();
		buyers[front % size] = null;
		front++;
	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
		if (((back + 1) % size) == (front % size)) revert(); 
		if (!empty()) {
			back++;
		}
		buyers[back % size].address = Buyer({
                address: msg.sender,
                timer: now,
                });
	}
}
