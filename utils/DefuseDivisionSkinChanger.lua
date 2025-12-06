local globalenv = getgenv or function()
  return shared
end
if globalenv.ns__DefuseDivisionSkinChanger == "ns__loaded" then
  return
end
-- l
globalenv.ns__DefuseDivisionSkinChanger = "ns__loaded"
