import nimgame2 / [entity]

###  unsafe constructor example  ###
# proc new(a:out Entity)=
#   a=newEntity()
###  example end  ###
proc new*[](T:type Entity,a:out T)=
  a=newEntity()

# proc new[](T:typedesc[Entity]):T=Entity.new result
# proc new*[](T:typedesc[int],a:out T)=
#   a=T()
proc new[](_:type int,value:int):ref int=
  new result
  result[]=value

if isMainModule:
  var 
    test_ent=Entity.new()
    test_int=int.new(123123)
  assert test_int[]==123123

    # test_string:string
  Entity.new test_ent
  