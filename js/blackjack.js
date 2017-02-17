// Generated by CoffeeScript 1.12.3
(function() {
  $(function() {
    return app.initialize();
  });

  window.app = {
    initialize: function() {
      var i, j, k, l, m, n, o, results;
      this.setBind();
      this.my_number = 0;
      this.dealer_number = 0;
      this.trump_number = new Array;
      for (i = k = 1; k <= 4; i = ++k) {
        this.trump_number[i] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
      }
      for (i = l = 1; l <= 4; i = ++l) {
        for (j = m = 1; m <= 13; j = ++m) {
          this.trump_number[i][j] = j;
          if (j >= 10) {
            this.trump_number[i][j] = 10;
          }
        }
      }
      this.check_trump_number = new Array;
      for (i = n = 1; n <= 4; i = ++n) {
        this.check_trump_number[i] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
      }
      results = [];
      for (i = o = 1; o <= 4; i = ++o) {
        results.push((function() {
          var p, results1;
          results1 = [];
          for (j = p = 1; p <= 13; j = ++p) {
            results1.push(this.check_trump_number[i][j] = 0);
          }
          return results1;
        }).call(this));
      }
      return results;
    },
    setBind: function() {
      $('#duel_start').on('click', (function(_this) {
        return function() {
          return _this.dealCard();
        };
      })(this));
      return $('#hit').on('click', (function(_this) {
        return function() {
          return _this.addMyCard('my');
        };
      })(this));
    },
    dealCard: function() {
      this.decideDealerNumber();
      return this.decideMyNumber();
    },
    decideDealerNumber: function() {
      var dealer_mark1, dealer_mark2, dealer_number1, dealer_number2, results;
      dealer_mark1 = _.random(1, 4);
      dealer_number1 = _.random(1, 13);
      while (this.check_trump_number[dealer_mark1][dealer_number1] === 1) {
        dealer_mark1 = _.random(1, 4);
        dealer_number1 = _.random(1, 13);
      }
      this.check_trump_number[dealer_mark1][dealer_number1] = 1;
      dealer_mark2 = _.random(1, 4);
      dealer_number2 = _.random(1, 13);
      while (this.check_trump_number[dealer_mark2][dealer_number2] === 1) {
        dealer_mark2 = _.random(1, 4);
        dealer_number2 = _.random(1, 13);
      }
      this.check_trump_number[dealer_mark2][dealer_number2] = 1;
      this.dealer_number = this.trump_number[dealer_mark1][dealer_number1] + this.trump_number[dealer_mark2][dealer_number2];
      console.log(this.dealer_number);
      results = [];
      while (this.dealer_number < 16) {
        results.push(this.addDealerCard());
      }
      return results;
    },
    decideMyNumber: function() {
      var my_mark1, my_mark2, my_number1, my_number2;
      my_mark1 = _.random(1, 4);
      my_number1 = _.random(1, 13);
      while (this.check_trump_number[my_mark1][my_number1] === 1) {
        my_mark1 = _.random(1, 4);
        my_number1 = _.random(1, 13);
      }
      this.check_trump_number[my_mark1][my_number1] = 1;
      my_mark2 = _.random(1, 4);
      my_number2 = _.random(1, 13);
      while (this.check_trump_number[my_mark2][my_number2] === 1) {
        my_mark2 = _.random(1, 4);
        my_number2 = _.random(1, 13);
      }
      this.check_trump_number[my_mark2][my_number2] = 1;
      this.my_number = this.trump_number[my_mark1][my_number1] + this.trump_number[my_mark2][my_number2];
      return console.log(this.my_number);
    },
    addMyCard: function() {
      var additional_mark, additional_number;
      additional_mark = _.random(1, 4);
      additional_number = _.random(1, 13);
      while (this.check_trump_number[additional_mark][additional_number] === 1) {
        additional_mark = _.random(1, 4);
        additional_number = _.random(1, 13);
      }
      this.check_trump_number[additional_mark][additional_number] = 1;
      this.my_number = this.my_number + this.trump_number[additional_mark][additional_number];
      return console.log(this.my_number);
    },
    addDealerCard: function() {
      var additional_mark, additional_number;
      additional_mark = _.random(1, 4);
      additional_number = _.random(1, 13);
      while (this.check_trump_number[additional_mark][additional_number] === 1) {
        additional_mark = _.random(1, 4);
        additional_number = _.random(1, 13);
      }
      this.check_trump_number[additional_mark][additional_number] = 1;
      this.dealer_number = this.dealer_number + this.trump_number[additional_mark][additional_number];
      return console.log(this.dealer_number);
    }
  };

}).call(this);
