pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Rental.sol";

//This Contract tests the rental contract
contract TestRental {

	//This is a persisting contract instance we can persist throughout the testing lifecycle to validate various aspects	
    Rental rental = Rental(DeployedAddresses.Rental());

    //Test instantiation of contract
    function testContractCreation () public {

    	//Initialize New Contract 
    	Rental newContract = Rental(DeployedAddresses.Rental());

    	//Check Car Count
    	uint count = newContract.getCarCount();

    	//Verify Registry is empty
		Assert.equal(count,0,"Registry Should be empty");	
    }

    //Verify A Car can be added to registry
    function testAddCarForRent() public{

    	//Verify Registry is empty
		Assert.equal(rental.getCarCount(),0,"Registry Should be empty");

		//Add Car to registry 
    	rental.addNewCar("Ford",0x126bF276bA4C7111dbddbb542718CfF678C9b3Ce,"5BFGH-ETG",2018);

    	//Verify Registry contains a car now
    	Assert.equal(rental.getCarCount(),1,"Car Not Added To Rental Registry");
    }

    //Test retrieval of car info 
    function testGetRentalCarInfo()  public {
    	//Ensure info matches the info added upon submission of first car 
    	 (string memory make, bool  availability, uint  year, uint  carID) =  rental.getRentalCarInfo(0);

    	 //Validate Make was accurately provided
    	Assert.equal(make,"Ford","Make was not stored properly");

    	//Validate that the car is available
    	Assert.equal(availability, true ,"Availability was not stored properly");

    	//Validate the year is correct
    	Assert.equal(year,2018 ,"Make was not stored properly");

    	//Validate the ID is correct
    	Assert.equal(carID,1,"CarId was not stored properly");
    }

    //Verify the count of the cars is accurate 
    function testGetCarCount() public {
    	//Verify Registry has one car 
		Assert.equal(rental.getCarCount(),1,"Registry Should Contain A Single Car");

		//Add Car to registry 
    	rental.addNewCar("Ford",0x126bF276bA4C7111dbddbb542718CfF678C9b3Ce,"5BFGH-ETG",2018);

		//Add Car to registry 
    	rental.addNewCar("BMW",0x126bF276bA4C7111dbddbb542718CfF678C9b3Ce,"SDFSFGFS",2018);

		//Add Car to registry 
    	rental.addNewCar("Honda",0x126bF276bA4C7111dbddbb542718CfF678C9b3Ce,"ABFGH-ETG",2015);

    	//Verify Registry contains 4 cars now
    	Assert.equal(rental.getCarCount(),4,"Car Not Added To Rental Registry");
    }

    //Verify that upon renting a car, rental funtion returns true 
    function testRentCar() public {
    	//Rent Car Currently available
    	bool result = rental.rent(0);

    	//Verify true was returned as successfully rented 
    	Assert.equal(result,true ,"Car Rented successfully");
    }

    //Verify that after car was rented, it is no longer available
    function testAvailabilityBool() public {
    	//Ensure bool indicates car is no longer available  
    	(, bool  availability, ,) =  rental.getRentalCarInfo(0);

    	//Validate that the car is not available
    	Assert.equal(availability, false ,"Availability was not stored properly");
    }




 //  	//Test addresss of unassignec car
	// function testUnassignedCarAddress() public {
	// 	Rental newRental = Rental(DeployedAddresses.Rental());
		
	// 	address[16] memory renters = newRental.getRenters();

	// 	uint arrayLength = renters.length;

	// 	for (uint i=0; i<arrayLength; i++) {
	// 		Assert.equal(renters[i],0x0000000000000000000000000000000000000000, "Renter Address Unused");
	// 	}

	// }


	// //Test renters addresss array of unassigned cars to ensure they are empty 
	// function testCarArrayAddress() public {
	// 	Rental newRental = Rental(DeployedAddresses.Rental());
		
	// 	address[16] memory renters = newRental.getRenters();

	// 	uint arrayLength = renters.length;

	// 	for (uint i=0; i<arrayLength; i++) {
	// 		Assert.notEqual(renters[i],0x1000000000000000000000000000000000000000, "Address Array Should Be Empty");
	// 	}

	// }


	// // Testing the adopt() function
	// function testUserCanRentCar() public {
	//   uint returnedId = rental.rent(8);

	//   uint expected = 8;

	//   Assert.equal(returnedId, expected, "Renter of car ID 8 should be recorded.");
	// }

	// 	// Testing retrieval of a single pet's owner
	// function testGetRenterAddressByCarId() public {
	//   // Expected owner is this contract
	//   address expected = this;

	//   address renter = rental.renters(8);

	//   Assert.equal(renter, expected, "Renter of car ID 8 should be recorded.");
	// }

	// 	// Testing retrieval of all pet owners
	// function testGetAdopterAddressByCarIdInArray() public {
	//   // Expected owner is this contract
	//   address expected = this;

	//   // Store adopters in memory rather than contract's storage
	//   address[16] memory renters = rental.getRenters();

	//   Assert.equal(renters[8], expected, "Renter of car ID 8 should be recorded.");
	// }


	// //Test storage of user address
	// function testSenderAddressSetAsRenter() public {

	// 	//Rent car 4
	// 	rental.rent(4);

	// 	//Get address for renter of car 4
	// 	address expected = this;

	// 	//Get address of car 4 renter
	// 	address car4renterAddress = rental.renters(4);

	// 	Assert.equal(car4renterAddress, expected, "Address set properly when renting");
	// }

}
