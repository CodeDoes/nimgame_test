import 
  nimgame2 / [
    entity, types, input
  ],
  helpers,
  polygon_graphic,
  circle_graphic

type
  PolygonEntity* = ref object of Entity
    points* : seq[Coord]


    
proc initPolygonEntity*(self:PolygonEntity)=
  self.initEntity()
  self.points= @[]
  var polygraphic= newPolygonGraphic()
  polygraphic.draw_filled= false
  self.graphic= polygraphic
  self.physics= defaultPhysics
  self.rotVel= 10.0
  
  self.logic= proc(entity: Entity, elapsed: float)=
    entity.graphic.PolygonGraphic.points= entity.PolygonEntity.points
    var 
      transform:Transform= (self.absPos, self.absRot, self.absScale, self.center)
      mpos= (mouse.abs.x, mouse.abs.y)
      local_mpos= transform.inverse_point(mpos)
    if MouseButton.left.down:
      if MouseButton.left.pressed: echo ("1 added point")
      self.points.add(local_mpos)
    if MouseButton.right.down:
      if MouseButton.right.down: echo ("2 set pos")
      self.pos= mpos
    if MouseButton.middle.down:
      if MouseButton.middle.down: echo ("3 set center")
      # self.center= self.center-local_mpos
      self.pos= mpos
      var i= 0
      while i < self.points.len:
        self.points[i]= self.points[i] - local_mpos
        i += 1
      self.center= (0.0, 0.0)
      self.graphic.PolygonGraphic.points = self.points
    # if mouseWheel.y != 0:
    self.rotVel += mouseWheel.y * 10.0
  
proc newPolygonEntity*(): PolygonEntity=
  new result
  result.initPolygonEntity()