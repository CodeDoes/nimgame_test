import 
  nimgame2/[
    textgraphic,
    entity
  ],
  assets




when isMainModule:
  import 
    nimgame2/[
      nimgame,
      scene,
      types,
      graphic,
      input,
      settings
    ],
    nimgame2/gui/widget,
    core,
    helpers,
    circle_graphic,
    frame
  proc newCircleEntity():Entity=
    var 
      cgraphic= newCircleGraphic()
    cgraphic.radius=4.0
    cgraphic.draw_border=false
    
    result = newEntity()
    result.graphic=cgraphic
    result.centrify()
  
  proc newTextEntityScene(): Scene=
    new result
    result.init()
    var 
      scene = result
    proc newEnt(text:string, pos:var Coord, rot:Angle= 0.0, scale:Scale= 1.0) =
      var 
        ent = newEntity()
        textgraphic = newTextGraphic(assets.default_font)
      scene.add(ent)
      ent.graphic=textgraphic

      textgraphic.setText text
      
      ent.scale= scale
      ent.pos= pos + (ent.relative_bottomleft * ent.absScale)
      ent.center += ent.relative_bottomleft
      echo ent.pos
      # Want rel_pos before rotation
      pos.y = ent.inverse_bottomleft.y 
      ent.rot= rot * 90.0
      for p in ent.inverse_corners:
        var cent = newCircleEntity()
        scene.add(cent)
        cent.pos = p
      var fEnt = newEntity()
      scene.add(fEnt)
      var fGraphic = newFrameGraphic()
      fEnt.graphic=fGraphic
      #new fGraphic.rect#=Rect#(ent.relative_topleft.toDim,ent.dim.toDim)
      fGraphic.draw_filled=false
      fGraphic.border_color=ColorRed
      fGraphic.rect.x = ent.relative_topleft.x.cint
      fGraphic.rect.y = ent.relative_topleft.y.cint
      fGraphic.rect.w = ent.dim.w.cint
      fGraphic.rect.h = ent.dim.h.cint
      
      # fEnt.toggle=true
      fEnt.logic = proc(ent:Entity,dt:float) =
        discard
        # ent.collider.PolyCollider.points=ent.graphic.FrameGraphic.points(
        #   pos= fEnt.pos,
        #   center= fent.center,
        #   angle= fent.rot,
        #   scale= fent.scale)
        # ent.collider.PolyCollider.updateFarthest()
        let color = (if ent.collider.collide(input.mouse.abs): ColorOrange else: ColorGreen)
        ent.graphic.FrameGraphic.border_color=color


      fEnt.center = ent.center
      fEnt.pos = ent.pos
      fEnt.rot = ent.rot
      fEnt.scale = ent.scale
      var corners = newseq[Coord]()
      for c in fent.relative_corners:
        corners.add(c)
      fEnt.collider = fEnt.newPolyCollider(fEnt.pos, corners)
    var
      rel_pos:Coord = (0.0, 0.0)
    for scale in [0.8,0.3,0.4,0.6,0.7,0.2]:
      newEnt("Scale Test", rel_pos, scale=scale)
    
    for f in [0.8,0.3,0.4,0.6,0.7,0.2]:
      newEnt("Rot Scale Test", rel_pos, rot=f, scale=f)
    
    rel_pos = (200.0,0.0)
    for rot in [0.8,0.3,0.4,0.6,0.7,0.2]:
      newEnt("Rot Test", rel_pos, rot=rot)
      
  game= newGame() 
  settings.updateInterval=1000
  if game.init(400, 400, "TextEntity module test"):
    assets.setup()
    game.scene= newTextEntityScene()
    settings.showInfo=true
    game.run()


