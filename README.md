# Decentral Rental

This project was built as a final project for [Consensys Academy Developer Program](https://courses.consensys.net/courses/course-v1:ConsenSysAcademy+2018DP+1/about)

This specific project represents a decentralized car rental serive. Where users can list and rent cars for others to use.

## Setup Instructions
This project uses:
- [Ganache](https://truffleframework.com/ganache) 
- [Truffle](https://truffleframework.com/truffle)
- [MetaMask](https://metamask.io/)

> Make sure you are running Ganache and Metmask Locally on Port 8545

Compile the Contracts with:  
```truffle compile```

Migrate Contracts with:  
```truffle migrate```

You can ensure the functions test past with:

`truffle test`

Intall Modules using:  
```npm install```

Run the client  
`npm run dev`

## User Stories

### Manage 
As the owner of the contract, I want to be able to manage the contract and kill further changes if necessary.
- 1. Deploy the contract and you are automatically assigned as the manager
- 2. In the event of a discovered vulnerability or safety implication, call `toggleContractActive` to pause rentals, returns, and new cars being added to the contract

### List Car for Rent
As a car owner, I want to be able to list a car for rent to be rented and declare it is available for rent once a user returns the car.
- 1. Complete the fields within the UI
- 2. Click the 'Add Car' button to add to the contract
- 3. The newly added car listing will appear and be available

### Rent A Car
As a user, I want to be able to see which cars are listed and rent an available one. 
- 1. Find a car that is listed as available
- 2. Press the rent button
- 3. The Car will no longer be available for rent and you will be marked as the current renter of the car

### Return A Car
- 1. Ensure you are the owner of the car by checking the car information
- 2. Once the car has been returned safely to you from renter, press the return button
- 3. The car will be available once again for rent

### See [Security Measures](./avoiding_common_attacks.md)

### See [Design Patterns](./design_pattern_desicions.md)
