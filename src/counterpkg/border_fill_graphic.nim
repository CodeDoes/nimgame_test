import 
  nimgame2 / [
    types, graphic
  ],
  helpers
type
  BorderFillGraphic* = ref object of Graphic
    border_color*, fill_color*: Color
    border_thickness*: float
    draw_border*, draw_filled*:bool
proc initBorderFillGraphic*(self:BorderFillGraphic)=
  self.draw_border = true
  self.draw_filled = true
method draw*(graphic: BorderFillGraphic,
             pos: Coord = (0.0, 0.0),
             angle: Angle = 0.0,
             scale: Scale = 1.0,
             center: Coord = (0.0, 0.0),
             flip: Flip = Flip.none,
             region: Rect = Rect(x: 0, y: 0, w: 0, h: 0))=
  raise newException(SystemError, "Can't use BorderFillGraphic draw method.")
  
method dim*(graphic: BorderFillGraphic): Dim=
  raise newException(SystemError, "Can't use BorderFillGraphic dim method.")
