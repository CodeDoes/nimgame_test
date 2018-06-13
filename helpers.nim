import 
  nimgame2 / [
    entity,types,utils,scene,graphic
  ]
# proc new*(_:type Entity):Entity=newEntity()
# proc del*(_:type Entity):Entity=newEntity()

proc dim*(self:Entity):Dim=
  return if self.sprite != nil:
      self.sprite.dim
    else:
      self.graphic.dim
{.this: self.}
proc topleft(self:Entity):Coord=self.center-self.dim.toCoord
proc bottomright(self:Entity):Coord=self.topleft+self.dim.toCoord
proc add*(self:Scene,ents:seq[Entity])=
  for e in ents:
    scene.add(self,e)
proc del*(self:Scene,ents:seq[Entity])=
  for e in ents:
    if scene.del(self,e):
      raise newException(SystemError,"Could not delete, entity is not part of scene")

proc getRelPoint*(self:Entity,point:Coord):Coord=
  return self.absPos+rotate(point,self.absRot)*self.absScale
type
  Transform* = tuple[pos:Coord,angle:Angle,scale:Scale,center:Coord]
proc point*(self:Transform,point:Coord):Coord=
  return self.pos+rotate(self.center+point,self.angle)*self.scale
proc inverse_point*(self:Transform,point:Coord):Coord=
  var 
    origin = self.pos+rotate(self.center,self.angle)*self.scale
    relpoint = origin-point
  return origin-rotate(relpoint,origin,-self.angle)
proc calcRect*(self:Graphic,offset:Coord):Rect=
  return Rect(
    x: (self.dim.w.float - offset.x).cint,
    y: (self.dim.h.float - offset.y).cint,
    w: self.dim.w.cint,
    h: self.dim.h.cint)
proc rect*(self:Entity):Rect=
  return self.graphic.calcRect(self.center*self.scale)