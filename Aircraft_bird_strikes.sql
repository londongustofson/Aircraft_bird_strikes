/*CREATE TABLE "HR"."FLIGHT_DATA" 
   (	"RECORD_ID" NUMBER, 
	"INCIDENT_YEAR" NUMBER, 
	"INCIDENT_MONTH" NUMBER, 
	"INCIDENT_DAY" NUMBER, 
	"OPERATOR_ID" VARCHAR2(255 BYTE), 
	"OPERATOR" VARCHAR2(255 BYTE), 
	"AIRCRAFT" VARCHAR2(255 BYTE), 
	"AIRPORT" VARCHAR2(255 BYTE), 
	"STATE" VARCHAR2(255 BYTE), 
	"WARNING_ISSUED" VARCHAR2(255 BYTE), 
	"FLIGHT_PHASE" VARCHAR2(255 BYTE), 
	"VISIBILITY" VARCHAR2(255 BYTE), 
	"PRECIPITATION" VARCHAR2(255 BYTE), 
	"HEIGHT" FLOAT(126), 
	"SPEED" FLOAT(126), 
	"DISTANCE" FLOAT(126), 
	"SPECIES_NAME" VARCHAR2(255 BYTE), 
	"FLIGHT_IMPACT" VARCHAR2(255 BYTE), 
	"FATALITIES" FLOAT(126), 
	"INJURIES" FLOAT(126), 
	"AIRCRAFT_DAMAGE" NUMBER, 
	"RADOME_STRIKE" NUMBER, 
	"RADOME_DAMAGE" NUMBER, 
	"WINDSHIELD_STRIKE" NUMBER, 
	"WINDSHIELD_DAMAGE" NUMBER, 
	"NOSE_STRIKE" NUMBER, 
	"NOSE_DAMAGE" NUMBER, 
	"ENGINE1_STRIKE" NUMBER, 
	"ENGINE1_DAMAGE" NUMBER, 
	"ENGINE2_STRIKE" NUMBER, 
	"ENGINE2_DAMAGE" NUMBER, 
	"ENGINE3_STRIKE" NUMBER, 
	"ENGINE3_DAMAGE" NUMBER, 
	"ENGINE4_STRIKE" NUMBER, 
	"ENGINE4_DAMAGE" NUMBER, 
	"ENGINE_INGESTED" NUMBER, 
	"PROPELLER_STRIKE" NUMBER, 
	"PROPELLER_DAMAGE" NUMBER, 
	"WING_OR_ROTOR_STRIKE" NUMBER, 
	"WING_OR_ROTOR_DAMAGE" NUMBER, 
	"FUSELAGE_STRIKE" NUMBER, 
	"FUSELAGE_DAMAGE" NUMBER, 
	"LANDING_GEAR_STRIKE" NUMBER, 
	"LANDING_GEAR_DAMAGE" NUMBER, 
	"TAIL_STRIKE" NUMBER, 
	"TAIL_DAMAGE" NUMBER, 
	"LIGHTS_STRIKE" NUMBER, 
	"LIGHTS_DAMAGE" NUMBER, 
	"OTHER_STRIKE" NUMBER, 
	"OTHER_DAMAGE" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSAUX" ;*/

/*select * from flight_data;*/

--1. Which bird is seen most often, strikes planes the most, or causes the most damage? 
-- Answer: Mourning Dove
/*select species_name, count(species_name)"Count of Birds"
from flight_data
group by species_name
order by count(species_name) desc;*/

--2. Top Aircraft Types with the Most Bird Strike Damage
-- Answer: Top Three(B-737-300, B-737-700,A-320)
/*select aircraft, Count(aircraft_damage)
from flight_data
group by aircraft 
order by count(aircraft_damage) desc;*/

--3. Which airlines are birds most eager to collide with?
-- Answer: Top Three (1.Southwest airlines, 2. United airlines 3. American airlines)
/*select operator, count(operator) birds_favorites
from flight_data
group by operator
order by birds_favorites desc;*/

--4. What birds are striking — and where? Do certain bird species tend to strike specific parts of the aircraft more than others?
-- Answer: GULLs lead all bird species in strike frequency, with a clear preference for hitting the wing and rotor areas. 
-- Sparrows tend to go for the windshield, while European Starlings also frequently strike the wing and rotor. 
-- Barn Swallows appear to favor the front of the aircraft, most often impacting the windshield and nose.
/*SELECT
  species_name,
  COUNT(CASE WHEN windshield_strike    != 0 THEN 1 END) AS windshield_count, 
  COUNT(CASE WHEN nose_strike          != 0 THEN 1 END) AS nose_count,
  COUNT(CASE WHEN wing_or_rotor_strike != 0 THEN 1 END) AS wing_rotor_count,
  COUNT(CASE WHEN fuselage_strike      != 0 THEN 1 END) AS fuselage_count,
  COUNT(CASE WHEN landing_gear_strike  != 0 THEN 1 END) AS gear_count,
  COUNT(CASE WHEN tail_strike          != 0 THEN 1 END) AS tail_count,
  COUNT(CASE WHEN lights_strike        != 0 THEN 1 END) AS lights_count
FROM flight_data
WHERE windshield_strike    != 0
   OR nose_strike          != 0
   OR wing_or_rotor_strike != 0
   OR fuselage_strike      != 0
   OR landing_gear_strike  != 0
   OR tail_strike          != 0
   OR lights_strike        != 0
GROUP BY species_name
ORDER BY 2 desc;*/

--5. Which bird species cause the most damage, and to which parts of the aircraft? 
-- Answer: The Black-bellied Whistling Duck is responsible for the least amount of damage, while the Canada Goose most frequently damages the wing or rotor and the nose of the aircraft.
-- Gulls also tend to favor the wing or rotor area.
/*SELECT
  species_name,
  COUNT(CASE WHEN windshield_damage    != 0 THEN 1 END) AS windshield_count, -- GULL Species
  COUNT(CASE WHEN nose_damage          != 0 THEN 1 END) AS nose_count, -- Canada Goose species
  COUNT(CASE WHEN wing_or_rotor_damage != 0 THEN 1 END) AS wing_rotor_count, -- Canada Goose species
  COUNT(CASE WHEN fuselage_damage     != 0 THEN 1 END) AS fuselage_count, -- Canada Goose species
  COUNT(CASE WHEN landing_gear_damage  != 0 THEN 1 END) AS gear_count, -- Canada Goose species
  COUNT(CASE WHEN tail_damage          != 0 THEN 1 END) AS tail_count, -- White-tailed deer species
  COUNT(CASE WHEN lights_damage        != 0 THEN 1 END) AS lights_count -- GULL Species
FROM flight_data
WHERE windshield_damage    != 0
   OR nose_damage          != 0
   OR wing_or_rotor_damage != 0
   OR fuselage_damage      != 0
   OR landing_gear_damage  != 0
   OR tail_damage          != 0
   OR lights_damage       != 0
GROUP BY species_name
ORDER BY 2 desc;*/

--6. What type of damage is most common when a bird hits the aircraft?
-- Answer: Top Three(Wing or rotor damage, nose damage, windshield damage)
/*SELECT 'WINDSHIELD_DAMAGE' AS damage_type, COUNT(*) AS total
FROM flight_data
WHERE windshield_damage = 1

UNION ALL

SELECT 'NOSE_DAMAGE', COUNT(*)
FROM flight_data
WHERE nose_damage = 1

UNION ALL

SELECT 'WING_OR_ROTOR_DAMAGE', COUNT(*)
FROM flight_data
WHERE wing_or_rotor_damage = 1

UNION ALL

SELECT 'FUSELAGE_DAMAGE', COUNT(*)
FROM flight_data
WHERE fuselage_damage = 1

UNION ALL

SELECT 'TAIL_DAMAGE', COUNT(*)
FROM flight_data
WHERE tail_damage = 1
order by 2 desc;*/


--7. At what point in the aircrafts journey do birds like to strike?
-- Answer: Top Three (1. Approach, 2. Takeoff Run 3. Landing Roll)
/*select flight_phase, count(species_name) as birds
from flight_data
WHERE flight_phase IS NOT NULL
group by flight_phase
order by birds desc;*/

--8. Which birds like to strike when the plane is approaching the runway?
-- Answer: Top Three(Gull, European Starling, and Sparrow)
/*Select species_name, count(species_name) species_count
from flight_data
WHERE flight_phase = 'APPROACH'
GROUP BY species_name
ORDER BY species_count desc;*/

--9. Do birds have a preferred time of year to strike planes?
-- Answer:(Summer months: 1.August 2.September 3.July)
/*SELECT 
  TO_CHAR(TO_DATE(incident_month, 'MM'), 'Month') AS month_name,
  COUNT(*) AS total_strikes
FROM flight_data
GROUP BY TO_CHAR(TO_DATE(incident_month, 'MM'), 'Month')
ORDER BY total_strikes DESC;*/

--10. Do more strikes happen during the day or at night?
-- Answer: Daytime accounts for nearly half of all bird strikes, with night and dusk following behind.
/*SELECT visibility, COUNT(*) AS aircrafts
FROM flight_data
WHERE visibility IS NOT NULL
GROUP BY visibility
ORDER BY aircrafts DESC;*/