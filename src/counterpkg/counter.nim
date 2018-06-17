
#[
proc newRefValDisplay(fnt,smlfnt:Font,refval: ref int):seq[Entity]=
  var top_ent = newEntity()
  var count_ent = newEntity()

  count_ent.graphic = newTextGraphic(smlfnt)
  count_ent.graphic.TextGraphic.setText("COUNT")
  
  count_ent.logic=proc(self:Entity,dt:float)=
    # self.origin
    self.centrify(left,bottom)
    let
      dim = top_ent.dim
    self.pos=(top_ent.center-dim.Coord)#TODO Swap with top_ent_rect.relativetopleft

  count_ent.parent=top_ent
  top_ent.graphic=newTextGraphic(fnt)
  top_ent.physics=defaultPhysics

  top_ent.logic=proc(self:Entity,dt:float)=
    self.graphic.TextGraphic.setText($refval[])
    self.centrify()
    self.pos=game.size.Coord/2.0
    self.scaleAcc=3.0-self.scale
    self.scaleDrg=1.0

  var 
    frame_ent = newEntity()

  frame_ent.parent=top_ent
  frame_ent.graphic=newFrameGraphic()
  frame_ent.logic=proc(self:Entity,dt:float)=
    self.centrify()
    self.pos= (0.0,0.0)
    var top_rect = top_ent.graphic.calcRect(top_ent.center)
    var label_rect = count_ent.graphic.calcRect(count_ent.center)

    top_rect.addr.unionRect(label_rect.addr,self.graphic.FrameGraphic.rect.addr) 
  # frame_graphic.dimProcedure=top_ent.dim
  
  return @[top_ent,count_ent,frame_ent]


proc newRefValIncreaser(refval:ref int):Entity=
  result = newEntity()
  result.logic=proc(self:Entity,dt:float)=
    refval[]+=1
]#



