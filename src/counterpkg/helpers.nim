import 
  nimgame2 / [
    entity, types, utils, scene, graphic
  ],
  color_helpers,
  assets
# proc new*(_:type Entity):Entity=newEntity()
# proc del*(_:type Entity):Entity=newEntity()
type
  GameObject = ref object of Entity
    m_children: seq[ref GameObject]
# proc dim*(self:Entity): Dim=
#   return if self.sprite != nil:
#       self.sprite.dim
#     else:
#       self.graphic.dim

iterator children*(self:GameObject):GameObject=
  let 
    cs = self.m_children
  for c in cs:
    yield c[]
proc initGameObject(self:GameObject)=
  self.m_children=newSeq[ref GameObject](0)
proc newGameObject*():GameObject=
  new result
  result.initGameObject()
proc add*(self: Scene, ent: GameObject)=
  scene.add(self, ent)
  for c in ent.children:
    self.add(c)
proc del*(self: Scene, ent: GameObject)=
  scene.add(self, ent)
  for c in ent.children:
    self.del(c)
# Bounds
type
  Bounds* = tuple[a: Coord, b: Coord]

#[
  # # Transform
  # type
  #   Transform* = tuple[pos: Coord, angle: Angle, scale: Scale]
  # proc transform*(self:Entity):Transform=
  #   return (
  #     pos: self.absPos, 
  #     angle: self.absRot, 
  #     scale: self.absScale).Transform
  # proc apply_relative_transform*(self: var Entity, transform: Transform)=
  #   self.pos = transform.pos 
  #   self.rot = transform.angle
  #   self.scale = transform.scale
  # proc apply*(self: var Transform, source: Transform)=
  #   self.pos = source.pos 
  #   self.angle = source.angle
  #   self.scale = source.scale
  # proc copy*(self: Transform):Transform=
  #   result.apply(self)
  # proc getRelPoint*(self: Entity,point: Coord): Coord=
  #   return self.absPos+rotate(point, self.absRot) * self.absScale
  # proc point*(self: Transform, point: Coord, scaled=true,rotated=true): Coord=
  #   return self.pos+rotate(point, (if rotated: self.angle else: 0.0)) * (if scaled: self.scale else: 1.0)
  # proc inverse_point*(self: Transform, point: Coord): Coord=
  #   var
  #     relpoint = self.pos-point
  #   return self.pos-rotate(relpoint, self.pos, -self.angle)
  # proc translated*(self: Transform, delta: Coord, scaled=false,rotated=false):Transform=
  #   result = self.copy()
  #   result.pos += result.point(delta, scaled, rotated)
  # proc rotated*(self:Transform, angle: float):Transform=
  #   result = self.copy()
  #   result.angle += angle
  # proc scaled*(self:Transform, scale: float):Transform=
  #   result = self.copy()
  #   result.scale *= scale
  # proc calcRect*(self: Graphic, offset: Coord): Rect=
  #   return Rect(
  #     x: (self.dim.w.float - offset.x).cint,
  #     y: (self.dim.h.float - offset.y).cint,
  #     w: self.dim.w.cint,
  #     h: self.dim.h.cint)
  # proc rect*(self: Entity):Rect=
  #   return self.graphic.calcRect(self.center * self.scale)
  # proc relative_center*(self:Entity): Coord= 
  #   self.center
  # proc relative_topleft*(self: Entity): Coord= 
  #   -self.center
  # proc relative_topright*(self: Entity): Coord= 
  #   -self.center + (self.dim.w.toFloat,0.0)
  # proc relative_bottomright*(self: Entity): Coord= 
  #   -self.center + self.dim.toCoord
  # proc relative_bottomleft*(self: Entity): Coord= 
  #   -self.center + (0.0,self.dim.h.toFloat)
  # proc inverse_center*(self: Entity): Coord= 
  #   self.transform.point(self.relative_center)
  # proc inverse_topleft*(self: Entity): Coord= 
  #   self.transform.point(self.relative_topleft)
  # proc inverse_topright*(self: Entity): Coord= 
  #   self.transform.point(self.relative_topright)
  # proc inverse_bottomright*(self: Entity): Coord= 
  #   self.transform.point(self.relative_bottomright)
  # proc inverse_bottomleft*(self: Entity): Coord= 
  #   self.transform.point(self.relative_bottomleft)
  # iterator relative_corners*(self:Entity):Coord=
  #   for c in [
  #     self.relative_topleft,
  #     self.relative_topright,
  #     self.relative_bottomright,
  #     self.relative_bottomleft,
  #     ]:
  #       yield c
  # iterator inverse_corners*(self:Entity):Coord=
  #   for c in [
  #     self.inverse_topleft,
  #     self.inverse_topright,
  #     self.inverse_bottomright,
  #     self.inverse_bottomleft,
  #     ]:
  #       yield c
]#
proc viewport_bounds*(self:Entity):Bounds=
  var
    a,b:Coord

  for c in self.world_corners:
    if a.declared:
      a=c
      b=c
      continue
    if a.x<c.x: a.x=c.x
    if a.y<c.y: a.y=c.y
    if b.x<c.x: b.x=c.x
    if b.y<c.y: b.y=c.y
    
    
    