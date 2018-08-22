pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Rental.sol";

contract TestRental {
  Rental rental = Rental(DeployedAddresses.Rental());

	  // Testing the adopt() function
	function testUserCanRentCar() public {
	  uint returnedId = rental.rent(8);

	  uint expected = 8;

	  Assert.equal(returnedId, expected, "Renter of car ID 8 should be recorded.");
	}

		// Testing retrieval of a single pet's owner
	function testGetRenterAddressByCarId() public {
	  // Expected owner is this contract
	  address expected = this;

	  address renter = rental.renters(8);

	  Assert.equal(renter, expected, "Renter of car ID 8 should be recorded.");
	}

		// Testing retrieval of all pet owners
	function testGetAdopterAddressByPetIdInArray() public {
	  // Expected owner is this contract
	  address expected = this;

	  // Store adopters in memory rather than contract's storage
	  address[16] memory renters = rental.getRenters();

	  Assert.equal(renters[8], expected, "Renter of car ID 8 should be recorded.");
	}


}
