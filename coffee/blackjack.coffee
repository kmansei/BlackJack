$ ->
  app.initialize()

window.app =
  initialize: ->
    @setBind()

    @my_number = 0
    @dealer_number = 0
    @add_mynumber = 3
    @add_dealernumber = 3
    #バーストフラグ
    @my_burst = 0
    @dealer_burst = 0

    #クローバー=1 ダイヤ=2 ハート=3 スペード=4
    @trump_number = new Array
    for i in [1..4]
      @trump_number[i] = [1..13]
    #1~10はそのままの値
    for i in [1..4]
      for j in [1..13]
        @trump_number[i][j] = j
        #1は11として扱う
        if j is 1
          @trump_number[i][j] = 11
        #10~13の数はブラックジャックでは10と扱う
        if j >= 10
          @trump_number[i][j] = 10

    #確認用
    @check_trump_number = new Array
    for i in [1..4]
      @check_trump_number[i] = [1..13]
    #未使用のカードは0 使用したら1
    for i in [1..4]
      for j in [1..13]
        @check_trump_number[i][j] = 0

  #クリックした時の動作
  setBind: ->
    $('#duel_start').on 'click', =>
      @duelStart()
    $('#hit').on 'click', =>
      @addMyCard "my#{@add_mynumber}"
      @add_mynumber++
    $('#stay').on 'click', =>
      @battle @dealer_number, @my_number

  #ゲーム開始
  duelStart: ->
    $('#duel_start').fadeOut 'normal'
    $('.center').fadeIn 'normal'
    @decideDealerNumber 'dealer1'
    console.log @dealer_number
    @decideMyNumber 'my1'
    @decideMyNumber 'my2'
    console.log @my_number

  #自分の始めのカードを決める
  decideMyNumber: (who)->
    mark = _.random 1, 4
    number = _.random 1, 13
    while @check_trump_number[mark][number] is 1
      mark = _.random 1, 4
      number = _.random 1, 13
    @check_trump_number[mark][number] = 1
    @my_number = @my_number + @trump_number[mark][number]
    $("#my").text @my_number
    $(".#{who}").attr 'src', "img/#{mark}_#{number}.png"

  #ディーラーの始めのカードを決める
  decideDealerNumber: (who)->
    mark = _.random 1, 4
    number = _.random 1, 13
    while @check_trump_number[mark][number] is 1
      mark = _.random 1, 4
      number = _.random 1, 13
    @check_trump_number[mark][number] = 1
    @dealer_number = @dealer_number + @trump_number[mark][number]
    $('#dealer').text '?'
    $(".#{who}").attr 'src', "img/#{mark}_#{number}.png"

  #自分がカードを引いたときの処理
  addMyCard: (who)->
    @decideMyNumber "my#{@add_mynumber}"
    $(".#{who}").show 'normal'
    if @my_number > 21
      @my_burst = 1
      $("#hit").prop "disabled", true
      $('.burst1').fadeIn 'fast'
    @drawed()
    console.log @my_number

  #ディーラーがカードを引いたときの処理
  addDealerCard: ->
    @decideDealerNumber "dealer#{@add_dealernumber}"
    $(".dealer#{@add_dealernumber}").show 'normal'
    if @dealer_number > 21
      @dealer_burst = 1
      $('.burst2').fadeIn 'fast'
    @add_dealernumber++
    @drawed()
    console.log @dealer_number

  drawed: ->
    $('.deck').fadeOut 'fast', =>
      $('.deck').fadeIn 'fast'

  #ディーラーがカードを加える
  battle: (dealer_number, mynumber)->
    @decideDealerNumber 'dealer2'
    $('.burst1').fadeOut 'fast'
    while @dealer_number < 17
      if @my_burst is 1
        break
      @addDealerCard()
    $("#dealer").text @dealer_number
    @judge()

  #勝敗を判定
  judge: ->
    $('#restart').show 'slow'
    if @dealer_burst is 1 and @my_burst is 1
      console.log 'あなたの負けです！'
      $('#lose').fadeIn 'fast'
    else if @dealer_burst is 1
      console.log 'あなたの勝ちです！'
      $('#win').fadeIn 'fast'
    else if @my_burst is 1
      console.log 'あなたの負けです！'
      $('#lose').fadeIn 'fast'
    else if @dealer_number is @my_number
      console.log '引き分けです。'
      $('#draw').fadeIn 'fast'
    else if @dealer_number > @my_number
      console.log 'あなたの負けです！'
      $('#lose').fadeIn 'fast'
    else
      console.log 'あなたの勝ちです！'
      $('#win').fadeIn 'fast'


