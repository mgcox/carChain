pragma solidity ^0.4.17;

contract Rental {

	//Number of Cars available for rent
	address[16] public renters;

	//Renting a car 
	function rent(uint carId) public returns (uint) {
	  require(carId >= 0 && carId <= 15);

	  renters[carId] = msg.sender;

	  return carId;
	}

		// Retrieving the adopters
	function getRenters() public view returns (address[16]) {
	  return renters;
	}



}
