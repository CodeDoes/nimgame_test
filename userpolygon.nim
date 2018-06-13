import 
  nimgame2 / [
    nimgame, entity, types, graphic, draw, utils, input
  ],
  helpers

type
  UserPolygonEntity* = ref object of Entity
    points* : seq[Coord]

  PolygonGraphic* = ref object of Graphic
    points* : seq[Coord]
proc newPolygonGraphic*():PolygonGraphic=
  new result
  result.points= @[]
method draw*(
        self: PolygonGraphic,
        pos: Coord,
        angle: Angle,
        scale: Scale,
        center: Coord,
        flip: Flip,
        region: Rect) = 
  var transform:Transform = (pos,angle,scale,center)
  var points: seq[Coord]= @[]
  for p in self.points:
    points.add(transform.point(p))
  discard polygon(points,ColorBlue)
  discard circle(transform.point((0.0,0.0)),4.0,ColorRed) #center
  discard circle(pos,4.0,ColorOrange) #pos
method dim(self:PolygonGraphic):Dim=
  var
    x1=0.0
    x2=0.0
    y1=0.0
    y2=0.0
  for p in self.points:
    x1=min(x1,p.x)
    x2=max(x2,p.x)
    y1=min(y1,p.y)
    y2=max(y2,p.y)
  var
    w=x2-x1
    h=y2-y1
  return (w,h)
    
proc initUserPolygonEntity*(self:UserPolygonEntity)=
  self.initEntity()
  self.points = @[]
  var proc_graphics=newPolygonGraphic()
  self.graphic = proc_graphics
  self.physics=defaultPhysics
  self.rotVel=10.0
  self.logic = proc(self:Entity,dt:float)=
    self.graphic.PolygonGraphic.points=self.UserPolygonEntity.points
    # self.centrify()
    
    # echo self.UserPolygonEntity.points,self.graphic.PolygonGraphic.points
method update(self:UserPolygonEntity,dt:float) =
  var 
    button = event.button
    transform:Transform = (self.absPos, self.absRot, self.absScale, self.center)
    mpos = (button.x.toFloat, button.y.toFloat).toCoord()
    local_mpos = transform.inverse_point(mpos)
  if MouseButton.left.down:
    echo ("1 added point")
    self.points.add(local_mpos)
  if MouseButton.right.down:
    echo ("2 set pos")
    self.pos = mpos
  if MouseButton.middle.down:
      echo ("3 set center")
      # self.center = self.center-local_mpos
      self.pos = mpos
      var i = 0
      while i < self.points.len:
        self.points[i] = self.points[i] - local_mpos
        i += 1
      self.center = (0.0, 0.0)
      self.graphic.PolygonGraphic.points = self.points
  of MOUSEWHEEL:
    self.rotVel += event.wheel.y.float * 10.0
  else:
    discard
proc newUserPolygonEntity*():UserPolygonEntity=
  new result
  result.initUserPolygonEntity()