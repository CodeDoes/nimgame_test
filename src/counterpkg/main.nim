import 
  nimgame2 / [
    nimgame,
    scene,
    types
  ],
  userpolygon


proc setup*(scene: Scene){.exportc.}=
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
  
  var polyEnt=newPolygonEntity()
  scene.add(polyEnt)
  polyEnt.points.add(( 30.0,   0.0))
  polyEnt.points.add((  0.0,  10.0))
  polyEnt.points.add((  0.0, -10.0))
  polyEnt.points.add((  -10.0,  10.0))
  polyEnt.points.add((  -10.0, -10.0))
  polyEnt.pos=nimgame.game.size.Coord/2.0
  var textEnt=new
  discard

proc destroy*(scene: Scene){.exportc.}=
  discard
if isMainModule:
  game=newGame()
  if game.init(400,400,"My Game"):
    var myscene = Scene()
    myscene.init()
    game.scene=myscene
    setup(myscene)
    game.run()