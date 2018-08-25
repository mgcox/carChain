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

Make sure you are running Ganache and Metmask Locally on Port 8545   
Run the client  
`npm run dev`

## User Stories

### Manage 
As the owner of the contract, I want to be able to manage the contract and kill further changes if necessary.

### List Car for Rent and Return
As a car owner, I want to be able to list a car for rent to be rented and declare it is available for rent once a user returns the car.

### Rent A Car
As a user, I want to be able to see which cars are listed and rent an available one. 

### See [Security Measures](./avoiding_common_attacks.md)

### See [Design Patterns](./design_pattern_desicions.md)
