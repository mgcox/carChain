App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    // Load cars.
    $.getJSON('../cars.json', function(data) {
      var carsRow = $('#carsRow');
      var carTemplate = $('#carTemplate');

      for (i = 0; i < data.length; i ++) {
        carTemplate.find('.panel-title').text(data[i].make);
        carTemplate.find('img').attr('src', data[i].picture);
        carTemplate.find('.car-licenseNumber').text(data[i].licenseNumber);
        carTemplate.find('.car-year').text(data[i].year);
        carTemplate.find('.car-cost').text(data[i].cost);
        carTemplate.find('.btn-rent').attr('data-id', data[i].id);

        carsRow.append(carTemplate.html());
      }
    });

    return App.initWeb3();
  },

  initWeb3: function() {
    // Is there an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fall back to Ganache
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('Rental.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var RentalArtifact = data;
      App.contracts.Rental = TruffleContract(RentalArtifact);

      // Set the provider for our contract
      App.contracts.Rental.setProvider(App.web3Provider);

      // Use our contract to retrieve and mark the adopted cars
      return App.markRented();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

  markRented: function(renters, account) {
    var rentalnInstance;

    App.contracts.Rental.deployed().then(function(instance) {
      rentalnInstance = instance;

      return rentalnInstance.getRenters.call();
    }).then(function(adopters) {
      for (i = 0; i < renters.length; i++) {
        if (renters[i] !== '0x0000000000000000000000000000000000000000') {
          $('.panel-car').eq(i).find('button').text('Success').attr('disabled', true);
        }
      }
    }).catch(function(err) {
      console.log(err.message);
    });
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

        // Execute adopt as a transaction by sending account
        return rentalnInstance.rent(carId, {from: account});
      }).then(function(result) {
        return App.markAdopted();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
