# Security Measures

**Compiler Warnings taken seriously**

The solidity code was inspected for static, compiler, and runtime errors and vulnerabilities. 

Considerations were referenced from multiple resources:
- [Security Recommendations](https://solidity.readthedocs.io/en/v0.4.24/security-considerations.html) 
- [Contract Safety and Security Checklist](https://www.kingoftheether.com/contract-safety-checklist.html)
- [Cross-Chain Replay Attacks](http://hackingdistributed.com/2016/07/17/cross-chain-replay/)
- [Known Attacks](https://consensys.github.io/smart-contract-best-practices/known_attacks/)

## Pathetic Evasion
This project explicately evades many of the pitfalls associated with `payable` risks and transactional exploits. Ideally, the rental process would support owners listing the rental rate of their car, the user placing some sort of collateral/proof of insurance/ proof of licence/ and other identity management tools. Each one of these pieces brings on added pitfalls which can happen Off-Chain, Cross-Chain, and On-Chain. 

For a lack of compentency, these features have not been implemented, but may be implemented in the future. In essense, the more features baked into the rental process, allow for even more liabilities. Especially for those renting their cars.

In order to support these features, I would prefer to fall-back on more bullet-proof robust projects for identity management and payment processing. 

## [Race Conditions](https://consensys.github.io/smart-contract-best-practices/known_attacks/#race-conditions42)
The implementation of the states found within this contract mitigate the risks of Race Condition Vulnerabilities.
To elaborate, Cross-Functional Race exploits are prevented for a single user given the facet that transactions are not sequentially dependent on other ones.

## [Front Running Vulnerabilites](https://consensys.github.io/smart-contract-best-practices/known_attacks/#transaction-ordering-dependence-tod-front-running)
Front-Running Manipulations is always a susceptability for contracts and can be difficult to defend against. In this case, a user could beat another user to the rental of a specific car. Ideally, the owner would delibrately agree to a specific rent reuqest. This would slow down the rental process. 

Use of assert for killswitch checks instead of require(). This ensures that all must-be-true arguements cannot be manipulated.
> Use assert(x) if you never ever want x to be false, not in any circumstance (apart from a bug in your code). Use require(x) if x can be false, due to e.g. invalid input or a failing external component. 

## [Gas Limit and Loops](https://solidity.readthedocs.io/en/v0.4.24/security-considerations.html#gas-limit-and-loops)
To avoid [Gas Limit and Loops](https://solidity.readthedocs.io/en/v0.4.24/security-considerations.html#gas-limit-and-loops) this project has no payable functions. Also, there are no iterative functions which iterate endlesslt over the array which could endlessly or extensively loop through the array of Rental Cars. There are no recursive calls that could ultimately support a nested withdraw or reentry exploits.

## Transactional Attacks
Many of the other vulnerabilities like [Integer Overflow and Underflow](https://consensys.github.io/smart-contract-best-practices/known_attacks/#integer-overflow-and-underflow), [DoS Threats](Integer Overflow and Underflow), and [Forcibly Sending Ether to a Contract](https://consensys.github.io/smart-contract-best-practices/known_attacks/#forcibly-sending-ether-to-a-contract) are avoided when the consequences of their occurances are diminished given that the contract serves as a utility without managing the exchange of funds. For example, if integer manipulation would result in renting the wrong car or fetching the wrong car info. However, because users are making changes on their own behalf with an impact almsot solely on themselves, they are somewhat incentivized not to nefariously manipulate their interaction with the contract. 

## Chain-Hopping
Imagine a user [Chain-hopping Contract Inputs](http://hackingdistributed.com/2016/07/17/cross-chain-replay/). If this contract was deployed on chain A, a user could secretely replay the chain on chain B, convince an owner they rented the car, by renting it on chain B, then using proof in a legal disute that there was no evidence of renting the car on chain A. Because this contract can be deployed endlessly, you would want to ensure that every interaction is with the same contract address on the same chain. 
