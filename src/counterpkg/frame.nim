import 
  nimgame2 / [
    types,graphic,draw,utils
  ],
  helpers,
  border_fill_graphic

type
  FrameGraphic* = ref object of BorderFillGraphic
    rect*: Rect
  AngledBounds* = ref object of RootObj
    bounds*: Bounds
    angle*: Angle
    center*: Coord
proc points*(abounds: AngledBounds,):seq[Coord]=
  let raw_points = [
    abounds.bounds.min, 
    (abounds.bounds.max.x, abounds.bounds.min.y),
    abounds.bounds.max, 
    (abounds.bounds.min.x, abounds.bounds.max.y),
    ] 
  result = newSeq[Coord](4)
  for i in 0..<4:
      result[i]= rotate(raw_points[i],abounds.center,abounds.angle)
proc points*(self:FrameGraphic,pos:Coord,angle:Angle,scale:Scale,center:Coord):seq[Coord]=
  var 
    abounds = new AngledBounds
  abounds.bounds= (min: -center*scale, max: (-center+self.dim.toCoord)*scale).Bounds
  abounds.angle = angle
  abounds.center = pos
  return abounds.points

proc initFrameGraphic(self:FrameGraphic)=
  self.initBorderFillGraphic()
  self.rect= Rect(x:0,y:0,w:0,h:0)
proc newFrameGraphic*():FrameGraphic=
  new result
  result.initFrameGraphic()
  
method dim*(self:FrameGraphic):Dim=(self.rect.w.int,self.rect.h.int)
proc drawFrameGraphic*( self: FrameGraphic,
                        pos: Coord,
                        angle: Angle,
                        scale: Scale,
                        center: Coord,
                        flip: Flip,
                        region: Rect )=
  var points = self.points(pos,angle,scale,center)
  if self.draw_border:
    discard draw.polygon(points, self.border_color, DrawMode.default)
  if self.draw_filled:
    discard draw.polygon(points, self.fill_color, DrawMode.filled)
  
method draw*(
    graphic: FrameGraphic,
    pos: Coord = (0.0, 0.0),
    angle: Angle = 0.0,
    scale: Scale = 1.0,
    center: Coord = (0.0, 0.0),
    flip: Flip = Flip.none,
    region: Rect = Rect(x: 0, y: 0, w: 0, h: 0))=
  drawFrameGraphic(graphic, pos, angle, scale, center, flip, region)