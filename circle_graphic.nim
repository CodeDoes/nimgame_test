import
  nimgame2 / [
    types, graphic, draw, utils
  ],
  helpers,
  border_fill_graphic

type
  CircleGraphic* = ref object of BorderFillGraphic
    radius*: float
    


proc drawCircleGraphic*(self: CircleGraphic,
                      pos: Coord = (0.0, 0.0),
                      angle: Angle = 0.0,
                      scale: Scale = 1.0,
                      center: Coord = (0.0, 0.0),
                      flip: Flip = Flip.none,
                      region: Rect = Rect(x: 0, y: 0, w: 0, h: 0)) =
  var point=(pos,angle,scale,center).Transform.point((0.0,0.0))
  discard circle(point, self.radius, self.fill_color, DrawMode.filled)
  discard circle(point, self.radius, self.border_color, DrawMode.default)




method draw*(graphic: CircleGraphic,
             pos: Coord = (0.0, 0.0),
             angle: Angle = 0.0,
             scale: Scale = 1.0,
             center: Coord = (0.0, 0.0),
             flip: Flip = Flip.none,
             region: Rect = Rect(x: 0, y: 0, w: 0, h: 0)) =
  drawCircleGraphic(graphic, pos, angle, scale, center, flip, region)
proc newCircleGraphic*():CircleGraphic=
  new result
  result.radius = 5.0
  result.fill_color=ColorPurple ## Traditional visual debugging color
  result.border_color=ColorPink

method dim*(self:CircleGraphic):Dim=
  return (int self.radius*2,int self.radius*2)



















