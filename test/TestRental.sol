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
    	 (string memory make, , , , bool  availability, uint  year, uint  carID) =  rental.getRentalCarInfo(0);

    	 //Validate Make was accurately provided
    	Assert.equal(make,"Ford","Make was not stored properly");

    	//Validate that the car is available
    	Assert.equal(availability, true ,"Availability was not stored properly");

    	//Validate the year is correct
    	Assert.equal(year,2018 ,"Make was not stored properly");

    	//Validate the ID is correct
    	Assert.equal(carID,0,"CarId was not stored properly");
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
    	(, , , , bool  availability, , ) =  rental.getRentalCarInfo(0);

    	//Validate that the car is not available
    	Assert.equal(availability, false ,"Availability was not stored properly");
    }

}
