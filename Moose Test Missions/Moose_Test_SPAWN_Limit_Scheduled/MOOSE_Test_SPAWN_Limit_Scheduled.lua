-- Tests Gudauta
-- --------------
-- Limited spawning of groups, scheduled every 30 seconds ...
Spawn_Plane_Limited_Scheduled = SPAWN:New( "Spawn Plane Limited Scheduled" ):Limit( 2, 20 ):SpawnScheduled( 30, 0 )
Spawn_Helicopter_Limited_Scheduled = SPAWN:New( "Spawn Helicopter Limited Scheduled" ):Limit( 2, 20 ):SpawnScheduled( 30, 0 )
Spawn_Ground_Limited_Scheduled = SPAWN:New( "Spawn Vehicle Limited Scheduled" ):Limit( 2, 20 ):SpawnScheduled( 90, 0 )

-- Tests Sukhumi
-- -------------
-- Limited spawning of groups, scheduled every seconds with destruction.
Spawn_Plane_Limited_Scheduled_RandomizeRoute = SPAWN:New( "Spawn Plane Limited Scheduled Destroy" ):Limit( 5, 20 ):SpawnScheduled( 10, 0 )
Spawn_Helicopter_Limited_Scheduled_RandomizeRoute = SPAWN:New( "Spawn Helicopter Limited Scheduled Destroy" ):Limit( 5, 20 ):SpawnScheduled( 10, 0 )
Spawn_Vehicle_Limited_Scheduled_RandomizeRoute = SPAWN:New( "Spawn Vehicle Limited Scheduled Destroy" ):Limit( 5, 20 ):SpawnScheduled( 10, 0 )


