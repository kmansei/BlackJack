$ ->
  app.initialize()

window.app =
  number:
    'my': 0
    'dealer': 0
#使うときは console.log @number.my @number['my']
  initialize: ->
    @setBind()

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
        #10~13は10として扱う
        if j >= 10
          @trump_number[i][j] = 10

    #確認用
    @check_trump_number = new Array
    for i in [0..4]
      @check_trump_number[i] = [0..13]
    #未使用のカードは0 使用したら1
    for i in [1..4]
      for j in [1..13]
        @check_trump_number[i][j] = 0
    @check_trump_number[0][0] = 1

  #クリックした時の動作
  setBind: ->

    $('#duel_start').on 'click', =>
      @duelStart()
    $('#hit').on 'click', =>
      @addMyCard "my#{@add_mynumber}"
      @add_mynumber++
    $('#stay').on 'click', =>
      @battle @number['dealer'], @number['my']
    $('#restart').on 'click', =>
      @restart()

  #ゲーム開始
  duelStart: ->
    $('#duel_start').fadeOut 'normal'
    $('.center').fadeIn 'normal'
    @decideNumber 'dealer1', 'dealer'
    console.log @number['dealer']
    @decideNumber 'my1', 'my'
    @decideNumber 'my2', 'my'
    $('#dealer').text '?'
    console.log @number['my']

  #自分の始めのカードを決める
  decideNumber: (who, player)->
    mark = number = 0
    while @check_trump_number[mark][number] is 1
      mark = _.random 1, 4
      number = _.random 1, 13
    @check_trump_number[mark][number] = 1
    @number["#{player}"] = @number["#{player}"] + @trump_number[mark][number]
    if number is 1 and @number["#{player}"] > 21
      @number["#{player}"] = @number["#{player}"] - 10
    $("##{player}").text @number["#{player}"]
    $(".#{who}").attr 'src', "img/#{mark}_#{number}.png"

  #自分がカードを引いたときの処理
  addMyCard: (who)->
    @decideNumber "my#{@add_mynumber}", 'my'
    $(".#{who}").show 'normal'
    if @number['my'] > 21
      @my_burst = 1
      $("#hit").prop "disabled", true
      $('.burst1').fadeIn 'fast'
    @drawed()
    console.log @number['my']

  #ディーラーがカードを引いたときの処理
  addDealerCard: ->
    @decideNumber "dealer#{@add_dealernumber}", 'dealer'
    $(".dealer#{@add_dealernumber}").show 'normal'
    if @number['dealer'] > 21
      @dealer_burst = 1
      $('.burst2').fadeIn 'fast'
    @add_dealernumber++
    @drawed()
    console.log @number['dealer']

  #山札からカードを引いたような演出
  drawed: ->
    $('.deck').fadeOut 'fast', =>
      $('.deck').fadeIn 'fast'

  #ディーラーがカードを引く
  battle: (dealernumber, mynumber)->
    @decideNumber 'dealer2', 'dealer'
    $('.burst1').fadeOut 'fast'
    while @number['dealer'] < 17
      if @my_burst is 1
        break
      @addDealerCard()
    $("#dealer").text @number['dealer']
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
    else if @number['dealer'] is @number['my']
      console.log '引き分けです。'
      $('#draw').fadeIn 'fast'
    else if @number['dealer'] > @number['my']
      console.log 'あなたの負けです！'
      $('#lose').fadeIn 'fast'
    else
      console.log 'あなたの勝ちです！'
      $('#win').fadeIn 'fast'

  #初期化
  restart: ->
    #確認用の配列を初期化
    for i in [1..4]
      for j in [1..13]
        @check_trump_number[i][j] = 0
    $('#restart').hide 'normal'
    $('#win').fadeOut 'normal'
    $('#lose').fadeOut 'normal'
    $('#draw').fadeOut 'normal'
    $('.burst2').fadeOut 'normal'
    @number['dealer'] = 0
    @number['my'] = 0
    @add_mynumber = 3
    @add_dealernumber = 3
    @my_burst = 0
    @dealer_burst = 0
    for i in [3..7]
      $(".dealer#{i}").hide 'fast'
      $(".my#{i}").hide 'fast'
    $('.dealer2').attr 'src', 'img/z02.png'
    $("#hit").prop "disabled", false
    @duelStart()


