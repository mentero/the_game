class @GameLoop
  constructor: ->
    @gameEngine = new GameEngine()
    @gameMenu   = new GameMenu(@gameEngine)
    @gameWindow = new GameWindow(@gameEngine)

    @startButton = $("#start")

  setup: =>
    @startButton.click =>
      if @playing
        @stopGame()
      else
        @startGame()

    @gameWindow.setup()

  update: =>
    @gameEngine.update()
    @gameMenu.update()
    @gameWindow.update()
    @gameWindow.render()

  startGame: =>
    @gameLoop = setInterval(@update, 1000/30)
    @playing = true
    @gameWindow.playing = true
    @startButton.text("Stop!")

  stopGame: =>
    clearInterval(@gameLoop)
    @playing = false
    @gameWindow.playing = false
    @startButton.text("Start!")
