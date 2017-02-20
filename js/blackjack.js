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
      this.add_mynumber = 3;
      this.add_dealernumber = 3;
      this.my_burst = 0;
      this.dealer_burst = 0;
      this.trump_number = new Array;
      for (i = k = 1; k <= 4; i = ++k) {
        this.trump_number[i] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
      }
      for (i = l = 1; l <= 4; i = ++l) {
        for (j = m = 1; m <= 13; j = ++m) {
          this.trump_number[i][j] = j;
          if (j === 1) {
            this.trump_number[i][j] = 11;
          }
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
          return _this.duelStart();
        };
      })(this));
      $('#hit').on('click', (function(_this) {
        return function() {
          _this.addMyCard("my" + _this.add_mynumber);
          return _this.add_mynumber++;
        };
      })(this));
      return $('#stay').on('click', (function(_this) {
        return function() {
          return _this.battle(_this.dealer_number, _this.my_number);
        };
      })(this));
    },
    duelStart: function() {
      $('#duel_start').fadeOut('normal');
      $('.center').fadeIn('normal');
      this.decideDealerNumber('dealer1');
      console.log(this.dealer_number);
      this.decideMyNumber('my1');
      this.decideMyNumber('my2');
      return console.log(this.my_number);
    },
    decideMyNumber: function(who) {
      var mark, number;
      mark = _.random(1, 4);
      number = _.random(1, 13);
      while (this.check_trump_number[mark][number] === 1) {
        mark = _.random(1, 4);
        number = _.random(1, 13);
      }
      this.check_trump_number[mark][number] = 1;
      this.my_number = this.my_number + this.trump_number[mark][number];
      if (number === 1 && this.my_number > 21) {
        this.my_number = this.my_number - 10;
      }
      $("#my").text(this.my_number);
      return $("." + who).attr('src', "img/" + mark + "_" + number + ".png");
    },
    decideDealerNumber: function(who) {
      var mark, number;
      mark = _.random(1, 4);
      number = _.random(1, 13);
      while (this.check_trump_number[mark][number] === 1) {
        mark = _.random(1, 4);
        number = _.random(1, 13);
      }
      this.check_trump_number[mark][number] = 1;
      this.dealer_number = this.dealer_number + this.trump_number[mark][number];
      if (number === 1 && this.dealer_number > 21) {
        this.dealer_number = this.dealer_number - 10;
      }
      $('#dealer').text('?');
      return $("." + who).attr('src', "img/" + mark + "_" + number + ".png");
    },
    addMyCard: function(who) {
      this.decideMyNumber("my" + this.add_mynumber);
      $("." + who).show('normal');
      if (this.my_number > 21) {
        this.my_burst = 1;
        $("#hit").prop("disabled", true);
        $('.burst1').fadeIn('fast');
      }
      this.drawed();
      return console.log(this.my_number);
    },
    addDealerCard: function() {
      this.decideDealerNumber("dealer" + this.add_dealernumber);
      $(".dealer" + this.add_dealernumber).show('normal');
      if (this.dealer_number > 21) {
        this.dealer_burst = 1;
        $('.burst2').fadeIn('fast');
      }
      this.add_dealernumber++;
      this.drawed();
      return console.log(this.dealer_number);
    },
    drawed: function() {
      return $('.deck').fadeOut('fast', (function(_this) {
        return function() {
          return $('.deck').fadeIn('fast');
        };
      })(this));
    },
    battle: function(dealer_number, mynumber) {
      this.decideDealerNumber('dealer2');
      $('.burst1').fadeOut('fast');
      while (this.dealer_number < 17) {
        if (this.my_burst === 1) {
          break;
        }
        this.addDealerCard();
      }
      $("#dealer").text(this.dealer_number);
      return this.judge();
    },
    judge: function() {
      $('#restart').show('slow');
      if (this.dealer_burst === 1 && this.my_burst === 1) {
        console.log('あなたの負けです！');
        return $('#lose').fadeIn('fast');
      } else if (this.dealer_burst === 1) {
        console.log('あなたの勝ちです！');
        return $('#win').fadeIn('fast');
      } else if (this.my_burst === 1) {
        console.log('あなたの負けです！');
        return $('#lose').fadeIn('fast');
      } else if (this.dealer_number === this.my_number) {
        console.log('引き分けです。');
        return $('#draw').fadeIn('fast');
      } else if (this.dealer_number > this.my_number) {
        console.log('あなたの負けです！');
        return $('#lose').fadeIn('fast');
      } else {
        console.log('あなたの勝ちです！');
        return $('#win').fadeIn('fast');
      }
    }
  };

}).call(this);
