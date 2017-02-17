$ ->
  app.initialize()

window.app =
  initialize: ->
    @setBind()

    #スペード=1 クローバー=2 ハート=3 ダイヤ=4 としてトランプを2次元配列で再現
    @number = new Array
    for i in [1..4]
      @number[i] = [1..13]
    #1~10はそのままの値
    for i in [1..4]
      for j in [1..13]
        @number[i][j] = j
        #10~13の数はブラックジャックでは10と扱う
        if j >= 10
          @number[i][j] = 10

    #確認用
    @checknumber = new Array
    for i in [1..4]
      @checknumber[i] = [1..13]
    #未使用のカードは0 使用したら1
    for i in [1..4]
      for j in [1..13]
        @checknumber[i][j] = 0


  setBind: ->
    $('#duel_start').on 'click', =>
      @dealCard()
    $('#hit').on 'click', =>
      @addCard()

  dealCard: ->
    #ディーラーの初手のカードを決める
    @decideNumber 'dealer'
    #自分の初手のカードを決める
    @decideNumber 'my'

  decideNumber: (who)->
    who_mark1 = _.random 1, 4
    who_number1 = _.random 1, 13
    #使用されていたらやり直し
    if  @checknumber[who_mark1][who_number1] is 1
      who_mark1 = _.random 1, 4
      who_number1 = _.random 1, 13
    @checknumber[who_mark1][who_number1] = 1

    who_mark2 = _.random 1, 4
    who_number2 = _.random 1, 13
    if @checknumber[who_mark2][who_number2] is 1
      who_number2 = _.random 1, 13
      who_mark2 = _.random 1, 4
    @checknumber[who_mark2][who_number2] = 1

    who_number = @number[who_mark1][who_number1] + @number[who_mark2][who_number2]
    #console.log who_number1
    #console.log who_mark1
    #console.log who_number2
    #console.log who_mark2
    console.log who_number

  addCard: ->





