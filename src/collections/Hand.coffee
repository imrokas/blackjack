class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @canPlay = true
    return

  hit: ->
    @add(@deck.pop()) if @canPlay

  stand: ->
    if @canPlay
      @canPlay = false
      @trigger('endTurn') 

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  more: ->
    first = @scores()[0]
    second = @scores()[1]
    limit = [17..21]
    if first  < 17 and second not in limit
      return true
    false

  bestScore: ->
    if not @deck .at 0
        .get 'revealed'
          return @minScore()
    first = @scores()[0]
    second = @scores()[1]
    optimalScore = [17..21]
    if first in optimalScore
      return first
    if second in optimalScore
      return second
    return first
