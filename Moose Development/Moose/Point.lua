--- This module contains the POINT classes.
-- 
-- 1) @{Point#POINT_VEC3} class, extends @{Base#BASE}
-- ===============================================
-- The @{Point#POINT_VEC3} class defines a 3D point in the simulator.
-- 
-- **Important Note:** Most of the functions in this section were taken from MIST, and reworked to OO concepts.
-- In order to keep the credibility of the the author, I want to emphasize that the of the MIST framework was created by Grimes, who you can find on the Eagle Dynamics Forums.
-- 
-- 1.1) POINT_VEC3 constructor
-- ---------------------------
--  
-- A new POINT instance can be created with:
-- 
--  * @{#POINT_VEC3.New}(): a 3D point.
--
-- 2) @{Point#POINT_VEC2} class, extends @{Point#POINT_VEC3}
-- =========================================================
-- The @{Point#POINT_VEC2} class defines a 2D point in the simulator. The height coordinate (if needed) will be the land height + an optional added height specified.
-- 
-- 2.1) POINT_VEC2 constructor
-- ---------------------------
--  
-- A new POINT instance can be created with:
-- 
--  * @{#POINT_VEC2.New}(): a 2D point.
-- 
-- @module Point
-- @author FlightControl

--- The POINT_VEC3 class
-- @type POINT_VEC3
-- @extends Base#BASE
-- @field DCSTypes#Vec3 PointVec3 
-- @field #POINT_VEC3.SmokeColor SmokeColor
-- @field #POINT_VEC3.FlareColor FlareColor
-- @field #POINT_VEC3.RoutePointAltType RoutePointAltType
-- @field #POINT_VEC3.RoutePointType RoutePointType
-- @field #POINT_VEC3.RoutePointAction RoutePointAction
POINT_VEC3 = {
  ClassName = "POINT_VEC3",
  SmokeColor = {
    Green = trigger.smokeColor.Green,
    Red = trigger.smokeColor.Red,
    White = trigger.smokeColor.White,
    Orange = trigger.smokeColor.Orange,
    Blue = trigger.smokeColor.Blue
  },
  FlareColor = {
    Green = trigger.flareColor.Green,
    Red = trigger.flareColor.Red,
    White = trigger.flareColor.White,
    Yellow = trigger.flareColor.Yellow
  },
  Metric = true,
  RoutePointAltType = {
    BARO = "BARO",
  },
  RoutePointType = {
    TurningPoint = "Turning Point",
  },
  RoutePointAction = {
    TurningPoint = "Turning Point",
  },
}


--- SmokeColor
-- @type POINT_VEC3.SmokeColor
-- @field Green
-- @field Red
-- @field White
-- @field Orange
-- @field Blue



--- FlareColor
-- @type POINT_VEC3.FlareColor
-- @field Green
-- @field Red
-- @field White
-- @field Yellow



--- RoutePoint AltTypes
-- @type POINT_VEC3.RoutePointAltType
-- @field BARO "BARO"



--- RoutePoint Types
-- @type POINT_VEC3.RoutePointType
-- @field TurningPoint "Turning Point"



--- RoutePoint Actions
-- @type POINT_VEC3.RoutePointAction
-- @field TurningPoint "Turning Point"



-- Constructor.
  
--- Create a new POINT_VEC3 object.
-- @param #POINT_VEC3 self
-- @param DCSTypes#Distance x The x coordinate of the Vec3 point, pointing to the North.
-- @param DCSTypes#Distance y The y coordinate of the Vec3 point, pointing Upwards.
-- @param DCSTypes#Distance z The z coordinate of the Vec3 point, pointing to the Right.
-- @return Point#POINT_VEC3 self
function POINT_VEC3:New( x, y, z )

  local self = BASE:Inherit( self, BASE:New() )
  self.PointVec3 = { x = x, y = y, z = z }
  self:F2( self.PointVec3 )
  return self
end

--- Create a new POINT_VEC3 object from  Vec3 coordinates.
-- @param #POINT_VEC3 self
-- @param DCSTypes#Vec3 Vec3 The Vec3 point.
-- @return Point#POINT_VEC3 self
function POINT_VEC3:NewFromVec3( Vec3 )

  return self:New( Vec3.x, Vec3.y, Vec3.z )
end


--- Return the coordinates of the POINT_VEC3 in Vec3 format.
-- @param #POINT_VEC3 self
-- @return DCSTypes#Vec3 The Vec3 coodinate.
function POINT_VEC3:GetVec3()
  return self.PointVec3
end

--- Return the coordinates of the POINT_VEC3 in Vec2 format.
-- @param #POINT_VEC3 self
-- @return DCSTypes#Vec2 The Vec2 coodinate.
function POINT_VEC3:GetVec2()
  return { x = self.PointVec3.x, y = self.PointVec3.z }
end


--- Return the x coordinate of the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @return #number The x coodinate.
function POINT_VEC3:GetX()
  self:F2(self.PointVec3.x)
  return self.PointVec3.x
end

--- Return the y coordinate of the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @return #number The y coodinate.
function POINT_VEC3:GetY()
  self:F2(self.PointVec3.y)
  return self.PointVec3.y
end

--- Return the z coordinate of the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @return #number The z coodinate.
function POINT_VEC3:GetZ()
  self:F2(self.PointVec3.z)
  return self.PointVec3.z
end

--- Return a random Vec3 point within an Outer Radius and optionally NOT within an Inner Radius of the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @param DCSTypes#Distance OuterRadius
-- @param DCSTypes#Distance InnerRadius
-- @return DCSTypes#Vec2 Vec2
function POINT_VEC3:GetRandomVec2InRadius( OuterRadius, InnerRadius )
  self:F2( { self.PointVec3, OuterRadius, InnerRadius } )

  local Theta = 2 * math.pi * math.random()
  local Radials = math.random() + math.random()
  if Radials > 1 then
    Radials = 2 - Radials
  end

  local RadialMultiplier
  if InnerRadius and InnerRadius <= OuterRadius then
    RadialMultiplier = ( OuterRadius - InnerRadius ) * Radials + InnerRadius
  else
    RadialMultiplier = OuterRadius * Radials
  end

  local RandomVec3
  if OuterRadius > 0 then
    RandomVec3 = { x = math.cos( Theta ) * RadialMultiplier + self:GetX(), y = math.sin( Theta ) * RadialMultiplier + self:GetZ() }
  else
    RandomVec3 = { x = self:GetX(), y = self:GetZ() }
  end
  
  return RandomVec3
end

--- Return a random Vec3 point within an Outer Radius and optionally NOT within an Inner Radius of the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @param DCSTypes#Distance OuterRadius
-- @param DCSTypes#Distance InnerRadius
-- @return DCSTypes#Vec3 Vec3
function POINT_VEC3:GetRandomVec3InRadius( OuterRadius, InnerRadius )

  local RandomVec2 = self:GetRandomVec2InRadius( OuterRadius, InnerRadius )
  local y = self:GetY() + math.random( InnerRadius, OuterRadius )
  local RandomVec3 = { x = RandomVec2.x, y = y, z = RandomVec2.z }

  return RandomVec3
end


--- Return a direction vector Vec3 from POINT_VEC3 to the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @param #POINT_VEC3 TargetPointVec3 The target PointVec3.
-- @return DCSTypes#Vec3 DirectionVec3 The direction vector in Vec3 format.
function POINT_VEC3:GetDirectionVec3( TargetPointVec3 )
  return { x = TargetPointVec3:GetX() - self:GetX(), y = TargetPointVec3:GetY() - self:GetY(), z = TargetPointVec3:GetZ() - self:GetZ() }
end

--- Get a correction in radians of the real magnetic north of the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @return #number CorrectionRadians The correction in radians.
function POINT_VEC3:GetNorthCorrectionRadians()
  local TargetVec3 = self:GetVec3()
  local lat, lon = coord.LOtoLL(TargetVec3)
  local north_posit = coord.LLtoLO(lat + 1, lon)
  return math.atan2( north_posit.z - TargetVec3.z, north_posit.x - TargetVec3.x )
end


--- Return a direction in radians from the POINT_VEC3 using a direction vector in Vec3 format.
-- @param #POINT_VEC3 self
-- @param DCSTypes#Vec3 DirectionVec3 The direction vector in Vec3 format.
-- @return #number DirectionRadians The direction in radians.
function POINT_VEC3:GetDirectionRadians( DirectionVec3 )
  local DirectionRadians = math.atan2( DirectionVec3.z, DirectionVec3.x )
  --DirectionRadians = DirectionRadians + self:GetNorthCorrectionRadians()
  if DirectionRadians < 0 then
    DirectionRadians = DirectionRadians + 2 * math.pi  -- put dir in range of 0 to 2*pi ( the full circle )
  end
  return DirectionRadians
end

--- Return the 2D distance in meters between the target POINT_VEC3 and the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @param #POINT_VEC3 TargetPointVec3 The target PointVec3.
-- @return DCSTypes#Distance Distance The distance in meters.
function POINT_VEC3:Get2DDistance( TargetPointVec3 )
  local TargetVec3 = TargetPointVec3:GetVec3()
  local SourceVec3 = self:GetVec3()
  return ( ( TargetVec3.x - SourceVec3.x ) ^ 2 + ( TargetVec3.z - SourceVec3.z ) ^ 2 ) ^ 0.5
end

--- Return the 3D distance in meters between the target POINT_VEC3 and the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @param #POINT_VEC3 TargetPointVec3 The target PointVec3.
-- @return DCSTypes#Distance Distance The distance in meters.
function POINT_VEC3:Get3DDistance( TargetPointVec3 )
  local TargetVec3 = TargetPointVec3:GetVec3()
  local SourceVec3 = self:GetVec3()
  return ( ( TargetVec3.x - SourceVec3.x ) ^ 2 + ( TargetVec3.y - SourceVec3.y ) ^ 2 + ( TargetVec3.z - SourceVec3.z ) ^ 2 ) ^ 0.5
end

--- Provides a Bearing / Range string
-- @param #POINT_VEC3 self
-- @param #number AngleRadians The angle in randians
-- @param #number Distance The distance
-- @return #string The BR Text
function POINT_VEC3:ToStringBR( AngleRadians, Distance )

  AngleRadians = UTILS.Round( UTILS.ToDegree( AngleRadians ), 0 )
  if self:IsMetric() then
    Distance = UTILS.Round( Distance / 1000, 2 )
  else
    Distance = UTILS.Round( UTILS.MetersToNM( Distance ), 2 )
  end

  local s = string.format( '%03d', AngleRadians ) .. ' for ' .. Distance

  s = s .. self:GetAltitudeText() -- When the POINT is a VEC2, there will be no altitude shown.

  return s
end

--- Provides a Bearing / Range string
-- @param #POINT_VEC3 self
-- @param #number AngleRadians The angle in randians
-- @param #number Distance The distance
-- @return #string The BR Text
function POINT_VEC3:ToStringLL( acc, DMS )

  acc = acc or 3
  local lat, lon = coord.LOtoLL( self.PointVec3 )
  return UTILS.tostringLL(lat, lon, acc, DMS)
end

--- Return the altitude text of the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @return #string Altitude text.
function POINT_VEC3:GetAltitudeText()
  if self:IsMetric() then
    return ' at ' .. UTILS.Round( self:GetY(), 0 )
  else
    return ' at ' .. UTILS.Round( UTILS.MetersToFeet( self:GetY() ), 0 )
  end
end

--- Return a BR string from a POINT_VEC3 to the POINT_VEC3.
-- @param #POINT_VEC3 self
-- @param #POINT_VEC3 TargetPointVec3 The target PointVec3.
-- @return #string The BR text.
function POINT_VEC3:GetBRText( TargetPointVec3 )
    local DirectionVec3 = self:GetDirectionVec3( TargetPointVec3 )
    local AngleRadians =  self:GetDirectionRadians( DirectionVec3 )
    local Distance = self:Get2DDistance( TargetPointVec3 )
    return self:ToStringBR( AngleRadians, Distance )
end

--- Sets the POINT_VEC3 metric or NM.
-- @param #POINT_VEC3 self
-- @param #boolean Metric true means metric, false means NM.
function POINT_VEC3:SetMetric( Metric )
  self.Metric = Metric
end

--- Gets if the POINT_VEC3 is metric or NM.
-- @param #POINT_VEC3 self
-- @return #boolean Metric true means metric, false means NM.
function POINT_VEC3:IsMetric()
  return self.Metric
end




--- Build an air type route point.
-- @param #POINT_VEC3 self
-- @param #POINT_VEC3.RoutePointAltType AltType The altitude type.
-- @param #POINT_VEC3.RoutePointType Type The route point type.
-- @param #POINT_VEC3.RoutePointAction Action The route point action.
-- @param DCSTypes#Speed Speed Airspeed in km/h.
-- @param #boolean SpeedLocked true means the speed is locked.
-- @return #table The route point.
function POINT_VEC3:RoutePointAir( AltType, Type, Action, Speed, SpeedLocked )
  self:F2( { AltType, Type, Action, Speed, SpeedLocked } )

  local RoutePoint = {}
  RoutePoint.x = self.PointVec3.x
  RoutePoint.y = self.PointVec3.z
  RoutePoint.alt = self.PointVec3.y
  RoutePoint.alt_type = AltType
  
  RoutePoint.type = Type
  RoutePoint.action = Action

  RoutePoint.speed = Speed / 3.6
  RoutePoint.speed_locked = true
  
--  ["task"] = 
--  {
--      ["id"] = "ComboTask",
--      ["params"] = 
--      {
--          ["tasks"] = 
--          {
--          }, -- end of ["tasks"]
--      }, -- end of ["params"]
--  }, -- end of ["task"]


  RoutePoint.task = {}
  RoutePoint.task.id = "ComboTask"
  RoutePoint.task.params = {}
  RoutePoint.task.params.tasks = {}
  
  
  return RoutePoint
end


--- Smokes the point in a color.
-- @param #POINT_VEC3 self
-- @param Point#POINT_VEC3.SmokeColor SmokeColor
function POINT_VEC3:Smoke( SmokeColor )
  self:F2( { SmokeColor, self.PointVec3 } )
  trigger.action.smoke( self.PointVec3, SmokeColor )
end

--- Smoke the POINT_VEC3 Green.
-- @param #POINT_VEC3 self
function POINT_VEC3:SmokeGreen()
  self:F2()
  self:Smoke( POINT_VEC3.SmokeColor.Green )
end

--- Smoke the POINT_VEC3 Red.
-- @param #POINT_VEC3 self
function POINT_VEC3:SmokeRed()
  self:F2()
  self:Smoke( POINT_VEC3.SmokeColor.Red )
end

--- Smoke the POINT_VEC3 White.
-- @param #POINT_VEC3 self
function POINT_VEC3:SmokeWhite()
  self:F2()
  self:Smoke( POINT_VEC3.SmokeColor.White )
end

--- Smoke the POINT_VEC3 Orange.
-- @param #POINT_VEC3 self
function POINT_VEC3:SmokeOrange()
  self:F2()
  self:Smoke( POINT_VEC3.SmokeColor.Orange )
end

--- Smoke the POINT_VEC3 Blue.
-- @param #POINT_VEC3 self
function POINT_VEC3:SmokeBlue()
  self:F2()
  self:Smoke( POINT_VEC3.SmokeColor.Blue )
end

--- Flares the point in a color.
-- @param #POINT_VEC3 self
-- @param Point#POINT_VEC3.FlareColor
-- @param DCSTypes#Azimuth (optional) Azimuth The azimuth of the flare direction. The default azimuth is 0.
function POINT_VEC3:Flare( FlareColor, Azimuth )
  self:F2( { FlareColor, self.PointVec3 } )
  trigger.action.signalFlare( self.PointVec3, FlareColor, Azimuth and Azimuth or 0 )
end

--- Flare the POINT_VEC3 White.
-- @param #POINT_VEC3 self
-- @param DCSTypes#Azimuth (optional) Azimuth The azimuth of the flare direction. The default azimuth is 0.
function POINT_VEC3:FlareWhite( Azimuth )
  self:F2( Azimuth )
  self:Flare( POINT_VEC3.FlareColor.White, Azimuth )
end

--- Flare the POINT_VEC3 Yellow.
-- @param #POINT_VEC3 self
-- @param DCSTypes#Azimuth (optional) Azimuth The azimuth of the flare direction. The default azimuth is 0.
function POINT_VEC3:FlareYellow( Azimuth )
  self:F2( Azimuth )
  self:Flare( POINT_VEC3.FlareColor.Yellow, Azimuth )
end

--- Flare the POINT_VEC3 Green.
-- @param #POINT_VEC3 self
-- @param DCSTypes#Azimuth (optional) Azimuth The azimuth of the flare direction. The default azimuth is 0.
function POINT_VEC3:FlareGreen( Azimuth )
  self:F2( Azimuth )
  self:Flare( POINT_VEC3.FlareColor.Green, Azimuth )
end

--- Flare the POINT_VEC3 Red.
-- @param #POINT_VEC3 self
function POINT_VEC3:FlareRed( Azimuth )
  self:F2( Azimuth )
  self:Flare( POINT_VEC3.FlareColor.Red, Azimuth )
end


--- The POINT_VEC2 class
-- @type POINT_VEC2
-- @field DCSTypes#Vec2 PointVec2
-- @extends Point#POINT_VEC3
POINT_VEC2 = {
  ClassName = "POINT_VEC2",
  }

--- Create a new POINT_VEC2 object.
-- @param #POINT_VEC2 self
-- @param DCSTypes#Distance x The x coordinate of the Vec3 point, pointing to the North.
-- @param DCSTypes#Distance y The y coordinate of the Vec3 point, pointing to the Right.
-- @param DCSTypes#Distance LandHeightAdd (optional) The default height if required to be evaluated will be the land height of the x, y coordinate. You can specify an extra height to be added to the land height.
-- @return Point#POINT_VEC2
function POINT_VEC2:New( x, y, LandHeightAdd )

  local LandHeight = land.getHeight( { ["x"] = x, ["y"] = y } )
  if LandHeightAdd then
    LandHeight = LandHeight + LandHeightAdd
  end
  
  local self = BASE:Inherit( self, POINT_VEC3:New( x, LandHeight, y ) )
  self:F2( { x, y, LandHeightAdd } )
  
  self.PointVec2 = { x = x, y = y }

  return self
end

--- Create a new POINT_VEC2 object from  Vec2 coordinates.
-- @param #POINT_VEC2 self
-- @param DCSTypes#Vec2 Vec2 The Vec2 point.
-- @return Point#POINT_VEC2 self
function POINT_VEC2:NewFromVec2( Vec2, LandHeightAdd )

  local self = BASE:Inherit( self, BASE:New() )

  local LandHeight = land.getHeight( Vec2 )
  if LandHeightAdd then
    LandHeight = LandHeight + LandHeightAdd
  end
  
  local self = BASE:Inherit( self, POINT_VEC3:New( Vec2.x, LandHeight, Vec2.y ) )
  self:F2( { Vec2.x, Vec2.y, LandHeightAdd } )

  self.PointVec2 = Vec2
  self:F2( self.PointVec3 )

  return self
end

--- Calculate the distance from a reference @{Point#POINT_VEC2}.
-- @param #POINT_VEC2 self
-- @param #POINT_VEC2 PointVec2Reference The reference @{Point#POINT_VEC2}.
-- @return DCSTypes#Distance The distance from the reference @{Point#POINT_VEC2} in meters.
function POINT_VEC2:DistanceFromPointVec2( PointVec2Reference )
  self:F2( PointVec2Reference )
  
  local Distance = ( ( PointVec2Reference.PointVec2.x - self.PointVec2.x ) ^ 2 + ( PointVec2Reference.PointVec2.y - self.PointVec2.y ) ^2 ) ^0.5
  
  self:T2( Distance )
  return Distance
end

--- Calculate the distance from a reference @{DCSTypes#Vec2}.
-- @param #POINT_VEC2 self
-- @param DCSTypes#Vec2 Vec2Reference The reference @{DCSTypes#Vec2}.
-- @return DCSTypes#Distance The distance from the reference @{DCSTypes#Vec2} in meters.
function POINT_VEC2:DistanceFromVec2( Vec2Reference )
  self:F2( Vec2Reference )
  
  local Distance = ( ( Vec2Reference.x - self.PointVec2.x ) ^ 2 + ( Vec2Reference.y - self.PointVec2.y ) ^2 ) ^0.5
  
  self:T2( Distance )
  return Distance
end


--- Return no text for the altitude of the POINT_VEC2.
-- @param #POINT_VEC2 self
-- @return #string Empty string.
function POINT_VEC2:GetAltitudeText()
  return ''
end

