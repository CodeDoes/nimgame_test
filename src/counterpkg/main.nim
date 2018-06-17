import 
  nimgame2 / [
    nimgame,
    scene,
    types
  ],
  userpolygon

type 
  MainScene* = ref object of Scene




proc init*(scene: MainScene)=
  #[ ## Other
  var
    count_val=new(int)
    myfont=newTrueTypeFont()
    smlfont=newTrueTypeFont()
  count_val[]=0

  if not myfont.load("assets/fnt/FSEX300.ttf", 32):
    raise newException(SystemError,myfont.getError())

  if not smlfont.load("assets/fnt/FSEX300.ttf", 10):
    raise newException(SystemError,smlfont.getError())
  
  scene.add(newRefValDisplay(myfont,smlfont, count_val))
  scene.add(newRefValIncreaser(count_val))
  ]#
  scene.Scene.init()
  
  var polyEnt=newPolygonEntity()
  scene.add(polyEnt)
  polyEnt.points.add(( 10.0,   0.0))
  polyEnt.points.add((-10.0,   0.0))
  polyEnt.points.add(( -2.0,  50.0))
  polyEnt.points.add((  2.0,  50.0))
  polyEnt.pos = nimgame.game.size.Coord/2.0
  # var textEnt=new
proc newMainScene*():MainScene=
  new result
  result.init()
proc destroy*(scene: Scene){.exportc.}=
  discard
if isMainModule:
  game=newGame()
  if game.init(400,400,"My Game"):
    game.scene = newMainScene()
    game.run()