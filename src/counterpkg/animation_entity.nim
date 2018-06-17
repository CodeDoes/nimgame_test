import 
  nimgame2 / gui / [
    widget,
    button
  ],
  nimgame2 / [
    entity
  ],
  helpers

type 
  AnimationState = tuple[entity: Entity, transform: Transform]
  AnimationControllerEntity = ref object of GuiWidget
    frames* : seq[AnimationState]


proc init*(self: AnimationControllerEntity) =
  self.GuiWidget.init()
  self.frames = newSeq[AnimationState]()


proc newAnimationControllerEntity*(): AnimationControllerEntity =
  new result
  result.init()