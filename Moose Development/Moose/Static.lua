--- This module contains the STATIC class.
-- 
-- 1) @{Static#STATIC} class, extends @{Unit#UNIT}
-- ===============================================
-- Statics are **Static Units** defined within the Mission Editor.
-- Note that Statics are almost the same as Units, but they don't have a controller.
-- The @{Static#STATIC} class is a wrapper class to handle the DCS Static objects:
-- 
--  * Wraps the DCS Static objects.
--  * Support all DCS Static APIs.
--  * Enhance with Static specific APIs not in the DCS API set.
-- 
-- 1.1) STATIC reference methods
-- -----------------------------
-- For each DCS Static will have a STATIC wrapper object (instance) within the _@{DATABASE} object.
-- This is done at the beginning of the mission (when the mission starts).
--  
-- The STATIC class does not contain a :New() method, rather it provides :Find() methods to retrieve the object reference
-- using the Static Name.
-- 
-- Another thing to know is that STATIC objects do not "contain" the DCS Static object. 
-- The STATIc methods will reference the DCS Static object by name when it is needed during API execution.
-- If the DCS Static object does not exist or is nil, the STATIC methods will return nil and log an exception in the DCS.log file.
--  
-- The STATIc class provides the following functions to retrieve quickly the relevant STATIC instance:
-- 
--  * @{#STATIC.FindByName}(): Find a STATIC instance from the _DATABASE object using a DCS Static name.
--  
-- IMPORTANT: ONE SHOULD NEVER SANATIZE these STATIC OBJECT REFERENCES! (make the STATIC object references nil).
-- 
-- @module Static
-- @author FlightControl






--- The STATIC class
-- @type STATIC
-- @extends Unit#UNIT
STATIC = {
	ClassName = "STATIC",
}


--- Finds a STATIC from the _DATABASE using the relevant Static Name.
-- As an optional parameter, a briefing text can be given also.
-- @param #STATIC self
-- @param #string StaticName Name of the DCS **Static** as defined within the Mission Editor.
-- @return #STATIC
function STATIC:FindByName( StaticName )
  local StaticFound = _DATABASE:FindStatic( StaticName )

  if StaticFound then
    StaticFound:F( { StaticName } )

  	return StaticFound
  end
  
  error( "STATIC not found for: " .. StaticName )
end

function STATIC:Register( StaticName )
  local self = BASE:Inherit( self, UNIT:Register( StaticName ) )

  self:F( StaticName )

  return self
end


function STATIC:GetDCSUnit()
  local DCSStatic = StaticObject.getByName( self.UnitName )
  
  if DCSStatic then
    return DCSStatic
  end
    
  return nil
end
