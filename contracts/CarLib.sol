pragma solidity ^0.4.17;

library CarLib {
    //This library contains helps create Car Objects for Rental Contracts
    struct Car {
        string make; // Car Model
        bool isAvailable;  // if true, this car can be rented out
        address rentee; // person delegated to
        address owner; //Owner of Car
        uint year;   // index of the voted proposal
        string licenseNumber; // Car identification
        uint carId; // index of car to be rented 
    }
}
