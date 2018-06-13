import 
  nimgame2 / [
    types,graphic,draw,utils
  ]

type
  FrameGraphic* = ref object of Graphic
    rect*: Rect
proc newFrameGraphic*():FrameGraphic=
  new result
  result.rect= Rect(x:0,y:0,w:0,h:0)
method dim*(self:FrameGraphic):Dim=(self.rect.w.int,self.rect.h.int)
proc drawFrameGraphic*( graphic: FrameGraphic,
                        pos: Coord,
                        angle: Angle,
                        scale: Scale,
                        center: Coord,
                        flip: Flip,
                        region: Rect )=
  var
    topleft = center-graphic.dim.toCoord
    bottomright = topleft+graphic.dim.toCoord
  var
    p1 = pos+rotate(topleft, (0.0, 0.0), angle)*scale
    p2 = pos+rotate(bottomright, (0.0, 0.0), angle)*scale
  discard draw.rect(
    p1,
    p2,
    ColorOrangeRed)
  discard draw.circle(p1, 4, ColorGreen)
  discard draw.circle(p2, 4, ColorPurple)
  
method draw*(
    graphic: FrameGraphic,
    pos: Coord = (0.0, 0.0),
    angle: Angle = 0.0,
    scale: Scale = 1.0,
    center: Coord = (0.0, 0.0),
    flip: Flip = Flip.none,
    region: Rect = Rect(x: 0, y: 0, w: 0, h: 0))=
  drawFrameGraphic(graphic, pos, angle, scale, center, flip, region)