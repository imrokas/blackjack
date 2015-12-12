# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
	initialize: ->
		@set 'deck', deck = new Deck()
		
		@set 'playerHand', deck.dealPlayer()
		
		@set 'dealerHand', deck.dealDealer()
		
		@get 'playerHand' 
			.on 'endTurn', () -> 
				@play()
			,@

		undefined

	play: ->
    @get 'dealerHand'
      .at 0
      .flip()
    dealer = @get 'dealerHand'

    #while dealer score < 17
    dealer.hit() while dealer.more()
    @winner()
    return;

  winner: ->
  	

		