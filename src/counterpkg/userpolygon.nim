import 
  nimgame2 / [
    entity, types, input, utils
  ],
  math,
  helpers,
  polygon_graphic,
  circle_graphic,
  color_helpers
from chroma import nil

type
  PolygonEntity* = ref object of Entity
    points*: seq[Coord]
    # animation_points*: seq[seq[Coord]]
    # animation_frame*: float



proc initPolygonEntity*(self:PolygonEntity)=
  self.initEntity()
  self.points=newSeq[Coord](1024*3)
  # self.animation_frame = 0.0
  # self.animation_points = @[
  #   self.m_points
  # ]
  var polygraphic= newPolygonGraphic()
  polygraphic.draw_filled= false
  polygraphic.points[]=newSeq[Coord](1024*3)
  self.graphic= polygraphic
  self.physics= defaultPhysics
  self.rotVel= 10.0
  self.logic= proc(entity: Entity, elapsed: float)=
    var poly_ent = entity.PolygonEntity
    # var hsv = entity.graphic.PolygonGraphic.border_color.toHSV
    entity.graphic.PolygonGraphic.border_color = chroma.spin(
      entity.graphic.PolygonGraphic.border_color,
      elapsed*360.0/3.0
    )
    entity.graphic.PolygonGraphic.fill_color = chroma.spin(
      entity.graphic.PolygonGraphic.fill_color,
      elapsed*360.0/3.0
    )
    #[
      let 
        anim_len = poly_ent.animation_points.len.float
        points = poly_ent.animation_points
        frame_completion = poly_ent.animation_frame mod 1.0

      poly_ent.animation_frame=(poly_ent.animation_frame) mod anim_len
      var 
        anim_from = points[poly_ent.animation_frame.int]
        anim_to = points[int((poly_ent.animation_frame + 1.0) mod anim_len.float)]
    
    for i in 0..<poly_ent.points.len:
      # simple lerp
      poly_ent.points[i]=(
        anim_from[i] * (1.0 - frame_completion) +
        anim_to[i] * frame_completion
      )
    ]#
    entity.graphic.PolygonGraphic.points[] = poly_ent.points
    let 
      transform:Transform= (self.absPos, self.absRot, self.absScale#[, self.center]#)
      mpos= (mouse.abs.x, mouse.abs.y)
      local_mpos= transform.inverse_point(mpos)
    if MouseButton.left.down:
      if MouseButton.left.pressed: echo ("1 added point")
      var
        dist: float
        closest= -1
      for i in 0..<self.points.len:
        let 
          p_dist=distance(self.points[i],local_mpos)
        if closest== -1 or p_dist < dist:
          dist = p_dist
          closest=i
      if closest== -1:
        self.points.add(local_mpos)
      else:
        self.points.insert(local_mpos,closest+1)
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
      self.graphic.PolygonGraphic.points[] = self.points
    # if mouseWheel.y != 0:
    self.rotVel += mouseWheel.y * 10.0
  
proc newPolygonEntity*(): PolygonEntity=
  new result
  result.initPolygonEntity()