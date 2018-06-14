from chroma import nil 
from nimgame2/types as ntypes import nil 

converter toNimgameColor*(input: chroma.ColorRGBA): ntypes.Color=
  return ntypes.Color(
    r: input.r, 
    g: input.g, 
    b: input.b, 
    a: input.a)
converter toColorRGBA*(input: ntypes.Color):chroma.ColorRGBA=
  return chroma.ColorRGBA(
    r: input.r, 
    g: input.g, 
    b: input.b, 
    a: input.a)
converter toColorRGBA2*(input: chroma.Color): chroma.ColorRGBA=
  return chroma.rgba(input)
converter toNimgameColor2*(input: chroma.Color): ntypes.Color=
  return chroma.rgba(input).toNimgameColor
converter toColor*(input: chroma.ColorRGBA): chroma.Color=
  return chroma.color(input)
converter toColor2*(input: ntypes.Color): chroma.Color=
  return chroma.color(input.toColorRGBA)

if isMainModule:
  var
    nC: ntypes.Color = chroma.parseHtmlName("aliceblue")
    cC: chroma.ColorRGBA = chroma.parseHtmlName("aliceblue")
    cBn: chroma.Color = nC
    cBc: chroma.Color = cC
    
  