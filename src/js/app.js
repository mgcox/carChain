App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    // // Load cars.
    // $.getJSON('../cars.json', function(data) {
    //   var carsRow = $('#carsRow');
    //   var carTemplate = $('#carTemplate');

    //   for (i = 0; i < data.length; i ++) {
    //     carTemplate.find('.panel-title').text(data[i].make);
    //     carTemplate.find('.car-make').text(data[i].make);
    //     carTemplate.find('img').attr('src', data[i].picture);
    //     carTemplate.find('.car-licenseNumber').text(data[i].licenseNumber);
    //     carTemplate.find('.car-isAvailable').text(data[i].isAvailable);
    //     carTemplate.find('.car-year').text(data[i].year);
    //     carTemplate.find('.btn-rent').attr('data-id', data[i].id);

    //     carsRow.append(carTemplate.html());
    //   }
    // });

    return App.initWeb3();
  },

  initWeb3: function() {
    // Is there an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fall back to Ganache
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
    }
    web3 = new Web3(App.web3Provider);
    console.log("web3 init")
    return App.initContract();
  },

  initContract: function() {
    $.getJSON('Rental.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var RentalArtifact = data;
      App.contracts.Rental = TruffleContract(RentalArtifact);

      // Set the provider for our contract
      App.contracts.Rental.setProvider(App.web3Provider);

      // Use our contract to retrieve and mark the rented cars
      return App.markRented();
    });

    App.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
    return App.bindEvents();
  },



  markRented: function(rentals, account) {
    var rentalInstance;

    App.contracts.Rental.deployed().then(function(instance) {
      rentalInstance = instance;
      return rentalInstance;
    }).then(function(rentalInstance) {

      rentalInstance.getCarCount().then(function(count){

        App.getAllCars(rentalInstance, account,  Number(count));
      });

    }).catch(function(err) {
      console.log(err.message);
    });
  },

  getAllCars: function(rentalInstance, account, count) {

      var carsRow = $('#carsRow');
      var carTemplate = $('#carTemplate');

      carsRow.empty();
      for (i = 0; i < count; i ++) {
        App.getCarInfo(rentalInstance,i).then(function(info) {

            var owner = info[2];

            var make = info[0];
            var isAvailable = info[4];
            carTemplate.find('.panel-title').text(make);
            carTemplate.find('.car-make').text(make);
            carTemplate.find('.car-licenseNumber').text(info[1]);
            carTemplate.find('.car-isAvailable').text(info[4]);
            carTemplate.find('.car-year').text(info[5]);
            carTemplate.find('.car-year').text(info[5]);
            carTemplate.find('.btn-rent').attr('data-id', info[6]);
            carTemplate.find('.btn-return').attr('data-id', info[6]);
            carTemplate.find('.btn-rent').attr('disabled', !isAvailable);
            carsRow.append(carTemplate.html());
        });
      }
  },


  getCarInfo: async function (rentalInstance, i) {
    return await rentalInstance.getRentalCarInfo(i);
  },

  handleRent: function(event) {
    event.preventDefault();

    var carId = parseInt($(event.target).data('id'));
    var rentalnInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.Rental.deployed().then(function(instance) {
        rentalnInstance = instance;

        // Execute rent as a transaction by sending account
        return rentalnInstance.rent(carId, {from: account, gas:3000000});
      }).then(function(result, account) {

        return App.markRented(account);
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  handleAddCar: function(event) {
    event.preventDefault();

    var carId = parseInt($(event.target).data('id'));
    var rentalnInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.Rental.deployed().then(function(instance) {
        rentalnInstance = instance;


        var make = document.getElementById("makeInfo").value;
        var owner = document.getElementById("owner").value;
        var year = document.getElementById("year").value;
        var license = document.getElementById("licenseNumber").value;

        // Execute rent as a transaction by sending account
        return rentalnInstance.addNewCar(make,owner,license,year, {from: account, gas:3000000});
      }).then(function(result) {
        return App.markRented();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },


  handleReturnCar: function(event) {
    event.preventDefault();

    var carId = parseInt($(event.target).data('id'));
    var rentalnInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.Rental.deployed().then(function(instance) {
        rentalnInstance = instance;


        console.log(carId);
        // Execute rent as a transaction by sending account
        return rentalnInstance.returnCar(carId, {from: account, gas:3000000});
      }).then(function(result) {
        return App.markRented();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },

  bindEvents: function() {
    $(document).on('click', '.btn-rent', App.handleRent);
    $(document).on('click', '.btn-return', App.handleReturnCar);
    $(document).on('click', '.btn-addCar', App.handleAddCar);
  }


};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
