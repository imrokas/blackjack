class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    lower = @$('img').attr 'src'
    	.toLowerCase()
    @$('img').attr 'src', lower
    if not @model.get 'revealed'
    	@$el.addClass 'covered'
    	@$('img').remove() 
    	return

