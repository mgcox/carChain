pragma solidity ^0.4.17;

import {CarLib} from "./CarLib.sol";

contract Rental {

	//Number of Cars available for rent
    CarLib.Car[] public rentals;

    //Return Total Number of Cars
    function getCarCount() public constant returns(uint) {
        return rentals.length;
    }

	//Renting a car 
	function rent(uint carId) public payable returns (bool) {
	   //Validate cardId is within array
	  uint totalCars = getCarCount();
	  
	//There must be a car to rent and ID # must be within range 
	  require(carId >= 0 && carId < totalCars);
    
    //
    CarLib.Car storage carToBeRented = rentals[carId];
    
    require(carToBeRented.isAvailable == true);
	  
	  //Assign Rentee to Sender
	  carToBeRented.rentee = msg.sender;
	  
	  //Remove Availability
      carToBeRented.isAvailable = false; 
      
     //Return Success
	  return true;
	}

    // Retrieving the car data necessary for user
	function getRentalCarInfo(uint carId) public view returns (string, string, address, address, bool, uint, uint) {
	  
	  uint totalCars = getCarCount();
	  require(carId >= 0 && carId < totalCars);
	  
	  //Get specified car 
	  CarLib.Car memory specificCar = rentals[carId];
	  
	  //Return data considered in rental process
	  return (specificCar.make,specificCar.licenseNumber, specificCar.owner ,specificCar.rentee, specificCar.isAvailable, specificCar.year , specificCar.carId);
	}

    //Add RentableCar
    function addNewCar(string make, address owner, string licenseNumber, uint year) public returns (uint) {
        //Create car object within function
        
        //Current # of cars
        uint count = getCarCount();
        //Increment Count
        //Construct Car Object
        CarLib.Car memory newCar = CarLib.Car(make,true, 0x0 , owner, year,licenseNumber,count);
        
        //Add to Array
        rentals.push(newCar);
        
         return count;
    }
    
    //Allow Car Owner to Mark car as returned
    function returnCar(uint carId) public payable returns (bool) {
        //Get Specific car
        CarLib.Car storage specificCar = rentals[carId];
        require(specificCar.owner == msg.sender);
        //Make car available again
        specificCar.isAvailable = true;
        //Remove previous rentee
        specificCar.rentee = 0x0;
        
        //Return Success
        return true;
    }

}