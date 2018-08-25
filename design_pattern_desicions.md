#Design Pattern Considerations

##Use of Library

The CarLib Library was used in order to potentially support further adoption and adaptations to decentralized rentals.
For example, if more features wanted to be added to the CarLib Struct, such as pricing for each car, then the Libary could be adapted to support those features, without having to change the contract itself. 

Furthermore, the rental contract could also be adapted to support a range of object libraries. This would allow decentralization of library conpatible objects. For example, instead of supporting CarLib, a specific Library could be passed in to support different objects like Motorcycles, Tools, Bicycles, Video Games, or any other object worth renting. While the contact does not currently support this feature, decoupling the CarLib from the Rental Contract was a clear step in that direction.
