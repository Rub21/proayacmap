﻿--DROP COLUMNS
ALTER TABLE build DROP COLUMN building;
ALTER TABLE build DROP COLUMN height;
ALTER TABLE build DROP COLUMN min_height;
ALTER TABLE build DROP COLUMN  "building:levels";
ALTER TABLE build DROP COLUMN  "building:material";
ALTER TABLE build DROP COLUMN  "source:height";
ALTER TABLE build DROP COLUMN "building:levels:underground";
ALTER TABLE build DROP COLUMN "building:part";
-- add per user
ALTER TABLE build DROP COLUMN "addr:street";
--others
ALTER TABLE build DROP COLUMN "addr:city";
ALTER TABLE build DROP COLUMN "addr:country";
-- roof
ALTER TABLE build DROP COLUMN "roof:material";
ALTER TABLE build DROP COLUMN "roof:shape";
ALTER TABLE build DROP COLUMN "roof:height";
--Add COLUMNS
ALTER TABLE build ADD COLUMN building varchar(5);
ALTER TABLE build ADD COLUMN height numeric;
ALTER TABLE build ADD COLUMN min_height numeric;
ALTER TABLE build ADD COLUMN  "building:levels" integer;
ALTER TABLE build ADD COLUMN  "building:material" varchar(100);
ALTER TABLE build ADD COLUMN  "source:height" varchar(100);
ALTER TABLE build ADD COLUMN "building:levels:underground" numeric;
ALTER TABLE build ADD COLUMN "building:part" varchar(3);
-- add per user
ALTER TABLE build ADD COLUMN "addr:street" varchar(100);
--others
ALTER TABLE build ADD COLUMN "addr:city" varchar(100);
ALTER TABLE build ADD COLUMN "addr:country" varchar(100);
-- roof
ALTER TABLE build ADD COLUMN "roof:material" varchar(100);
ALTER TABLE build ADD COLUMN "roof:shape" varchar(100);
ALTER TABLE build ADD COLUMN "roof:height" numeric;

--======================================01 piso==============================
UPDATE build
   SET  building = 'yes', height=2.5 , "building:material"='rustic',"roof:material"='slate',"roof:shape" = 'gabled', "roof:height" = 1.5, "addr:city"='Ayacucho', "addr:country"='Perú'
 WHERE layer='01_PRIMER PISO RUSTICO'or layer='01_PISO_MR';
 
 UPDATE build
   SET  building = 'yes', height=3 , "building:material"='concrete',"roof:material"='concrete',"roof:shape" = 'flat', "addr:city"='Ayacucho', "addr:country"='Perú'
 WHERE layer='01_PRIMER PISO  NOBLE' or layer='01_PISO_MN';
UPDATE build
   SET  "building:levels"=1
 WHERE layer='01_PRIMER PISO RUSTICO' OR layer='01_PRIMER PISO  NOBLE' OR layer='01_PISO_MN' OR layer='01_PISO_MR' OR layer='01_PISO_MR' ;

--=====================01 sotano	
UPDATE build
   SET   "building:levels:underground"=1, "building:part"='yes', height=2
 WHERE layer='01_SOTANO_NOBLE' or layer='01_SOTANO_RUSTICO' or layer='SOTANO_01' or layer='LOTE 01 MR' or layer='SOTANO-01 MR' or layer='01_SOTANO_ NOBLE' ;

--======================================02 piso==============================
select count(*) as num, layer from build where position('02' in lower(layer))>0  group by layer order by  num desc;
UPDATE build
   SET   "building:part"='yes', height=4.5 , "building:material"='rustic',"roof:material"='slate',"roof:shape" = 'gabled', min_height=2.5 , "roof:height" = 1.5
WHERE layer='02_SEGUNDO PISO RUSTICO' or layer='02_PISO_MR';

UPDATE build
   SET   "building:part"='yes', height=5.5 , "building:material"='concrete' ,"roof:material"='concrete',"roof:shape" = 'flat', min_height=3
 WHERE layer='02_SEGUNDO PISO NOBLE' or layer='02_PISO_MN';
UPDATE build
   SET  "building:levels"=2
 WHERE layer='02_SEGUNDO PISO NOBLE' OR layer='02_SEGUNDO PISO RUSTICO' OR layer='02_PISO_MR' OR layer='02_PISO_MN';
02 sotano
UPDATE build
   SET   "building:levels:underground"=2, "building:part"='yes', height=1.9
 WHERE layer='02_SOTANO_NOBLE' or layer='LOTE02 MR' or layer='02_SOTANO_RUSTICO';
 --=================03 piso
select count(*) as num, layer from build where position('03' in lower(layer))>0 AND position('piso' in lower(layer))>0 group by layer order by  num desc;

 UPDATE build
   SET   "building:part"='yes', height=6.5 , "building:material"='rustic',"roof:material"='slate',"roof:shape" = 'gabled', min_height=4.5, "roof:height" = 1.5
  WHERE layer='03_TERCER PISO RUSTICO';
  
 UPDATE build
   SET   "building:part"='yes', height=8 ,  "building:material"='concrete',"roof:material"='concrete',"roof:shape" = 'flat', min_height=5.5
  WHERE layer='03_TERCER PISO NOBLE' or layer='03_PISO_MN';

UPDATE build
   SET  "building:levels"=3
 WHERE layer='03_TERCER PISO NOBLE' OR layer='03_PISO_MN' OR  layer='03_TERCER PISO RUSTICO';
 --=================04 piso
select count(*) as num, layer from build where position('04' in lower(layer))>0 AND position('piso' in lower(layer))>0 group by layer order by  num desc;

UPDATE build
   SET   "building:part"='yes', height=8.5 , "building:material"='rustic',"roof:material"='slate',"roof:shape" = 'gabled', min_height=6.5
  WHERE layer='04_CUARTO PISO RUSTICO';
  
UPDATE build
   SET   "building:part"='yes', height=10.5 , "building:material"='concrete',"roof:material"='concrete',"roof:shape" = 'flat', min_height=8
  WHERE layer='04_CUARTO PISO NOBLE';
  
UPDATE build
   SET  "building:levels"=4
 WHERE layer='04_CUARTO PISO NOBLE' OR layer='04_CUARTO PISO RUSTICO';
--=================05 piso
select count(*) as num, layer from build where position('05' in lower(layer))>0 AND position('piso' in lower(layer))>0 group by layer order by  num desc;

UPDATE build
   SET   "building:part"='yes', height=13 ,  "building:material"='concrete',"roof:material"='concrete',"roof:shape" = 'flat', min_height=10.5
  WHERE layer='05_QUINTO PISO NOBLE';
 
UPDATE build
   SET  "building:levels"=5
 WHERE layer='05_QUINTO PISO NOBLE';

  --=================06 piso
select count(*) as num, layer from build where position('06' in lower(layer))>0 AND position('piso' in lower(layer))>0 group by layer order by  num desc;

UPDATE build
   SET   "building:part"='yes', height=15.5,  "building:material"='concrete',"roof:material"='concrete',"roof:shape" = 'flat', min_height=13
  WHERE layer='06_SEXTO PISO NOBLE';

UPDATE build
   SET  "building:levels"=6
 WHERE layer='06_SEXTO PISO NOBLE';
 
  --=================07 piso
select count(*) as num, layer from build where position('07' in lower(layer))>0 AND position('piso' in lower(layer))>0 group by layer order by  num desc;

UPDATE build
   SET  "building:part"='yes', height=18 ,  "building:material"='concrete',"roof:material"='concrete',"roof:shape" = 'flat', min_height=15.5
WHERE layer='07_SEPTIMO PISO NOBLE';

UPDATE build
   SET  "building:levels"=7
WHERE layer='07_SEPTIMO PISO NOBLE';
--================= balcones

select count(*) as num, layer from build where position('balcon' in lower(layer))>0 group by layer order by  num desc;

UPDATE build
   SET  "building:part"='yes', height = 4, min_height=3 
  WHERE layer='BALCON_2P' or layer='BALCON 2P';

UPDATE build
   SET  "building:part"='yes', height = 6.5, min_height=5.5   
  WHERE layer='BALCON_3P';
  
UPDATE build
   SET  "building:part"='yes', height = 9, min_height=8      
  WHERE layer='BALCON_4P';

UPDATE build
   SET  "building:part"='yes', height = 11.5, min_height=10.5   
  WHERE layer='BALCON_5P';
  
--================= source:height
UPDATE build
   SET "source:height"='estimate';
--================= corredores

select count(*) as num, layer from build where position('corredor' in lower(layer))>0 group by layer order by  num desc;

UPDATE build
   SET  "building:part"='yes', height = 3
  WHERE layer='CORREDOR 1P' or layer='CORREDOR_1P';

UPDATE build
   SET  "building:part"='yes', height = 5.5  
  WHERE layer='CORREDOR 2P';

  
UPDATE build
   SET  "building:part"='yes', height =8   
  WHERE layer='CORREDOR 3P' or layer='CORREDOR_3P';

UPDATE build
   SET  "building:part"='yes', height =10.5   
  WHERE layer='CORREDOR_4P';

  --================= corredores

--select count(*) as num, layer from build where position('escalera' in lower(layer))>0 group by layer order by  num desc;

/*UPDATE build
   SET  "building:part"='yes', height = 3 , "roof:shape"='skillion'
  WHERE layer='ESCALERA_CONCRETO_1P' or layer='ESCALERA_METALICA_1P';

UPDATE build
   SET  "building:part"='yes', height = 5.5 , "roof:shape"='skillion',min_height=3  
  WHERE layer='ESCALERA_CONCRETO_2P' or layer='ESCALERA_METALICA_2P';


UPDATE build
   SET  "building:part"='yes', height = 8 , "roof:shape"='skillion',min_height=5.5 
  WHERE layer='ESCALERA_METALICA_3P' or layer='ESCALERA_METALICA_3P';


UPDATE build
   SET  "building:part"='yes', height = 10.5 , "roof:shape"='skillion',min_height=8
  WHERE layer='ESCALERA_CONCRETO_4P' or layer='ESCALERA_METALICA_4P';

UPDATE build
   SET  "building:part"='yes', height = 13 , "roof:shape"='skillion',min_height=10.5
  WHERE layer='ESCALERA_CONCRETO_5P' or layer='ESCALERA_METALICA_5P';*/

--=================CONSTRUCCIONES COMPLEMENTARIAS
select count(*) as num, layer from build where position('construcciones' in lower(layer))>0 group by layer order by  num desc;

UPDATE build
   SET  "building"='yes'  
  WHERE layer='CONSTRUCCIONES COMPLEMENTARIAS';

UPDATE build
   SET  "building"=''  
  WHERE gid=13121;





  
  