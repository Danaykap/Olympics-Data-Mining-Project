--After importing all data..

/*There are countries that appear with NOC code and Country name that don't match. The following queries may not work due to some 
non readable (non ASCII) characters that exist at the end of notes column (noc table). In this case, you can have a look at the 
following StackOverflow post: https://stackoverflow.com/questions/21585914/trim-spaces-in-string-ltrim-rtrim-not-working/21586480
Alternatively, if you want an easy solution, using Azure Data Studio you can remove empty spaces manually, at end of each value,
using the Edit Data tool (right click on the relevant table :P).*/

UPDATE noc SET region='Netherlands Antilles' WHERE notes ='Netherlands Antilles';
UPDATE noc SET region='Antigua and Barbuda' WHERE notes='Antigua and Barbuda';
UPDATE noc SET region='Australasia' WHERE notes='Australasia';
UPDATE noc SET region='Bohemia' WHERE notes='Bohemia';
UPDATE noc SET region='Crete' WHERE notes='Crete';
UPDATE noc SET region='Hong Kong' WHERE notes='Hong Kong';
UPDATE noc SET region='North Borneo' WHERE notes='North Borneo';
UPDATE noc SET region='Newfoundland' WHERE notes='Newfoundland';
UPDATE noc SET region='Refugee Olympic Team' WHERE notes='Refugee Olympic Team';
UPDATE noc SET region='Serbia and Montenegro' WHERE notes='Serbia and Montenegro';
UPDATE noc SET region='Trinidad and Tobago' WHERE notes='Trinidad and Tobago';
UPDATE noc SET region='Tuvalu' WHERE notes='Tuvalu';
UPDATE noc SET region='United Arab Republic' WHERE notes='United Arab Republic';
UPDATE noc SET region='West Indies Federation' WHERE notes='West Indies Federation';
UPDATE noc SET region='North Yemen' WHERE notes='North Yemen';
UPDATE noc SET region='South Yemen' WHERE notes='South Yemen';
UPDATE noc SET region='Yugoslavia' WHERE notes='Yugoslavia';
UPDATE noc SET region='Bolivia' WHERE region='Boliva';
UPDATE noc SET region='Czechoslovakia' WHERE NOC='TCH';
UPDATE noc SET region='West Germany' WHERE NOC='FRG';
UPDATE noc SET region='East Germany' WHERE NOC='GDR';
UPDATE noc SET region='Saar' WHERE NOC='SAA';
UPDATE noc SET region='Malaya' WHERE NOC='MAL';
UPDATE noc SET region='Soviet Union' WHERE NOC='URS';
UPDATE noc SET region='Unified Team' WHERE NOC='EUN';
UPDATE noc SET region='South Vietnam' WHERE NOC='VNM';
UPDATE noc SET region='Rhodesia' WHERE NOC='RHO';

--There is different NOC code for Singapore at Athletes table and NOC table.

UPDATE noc SET NOC='SGP' WHERE region='Singapore';
 
--There are different country names for some countries between LonLat and noc tables

UPDATE LonLat SET name='Antigua and Barbuda' WHERE name='Antigua & Barbuda';
UPDATE LonLat SET name='Bosnia and Herzegovina' WHERE name='Bosnia';
UPDATE LonLat SET name='Virgin Islands, British' WHERE name='British Virgin Islands';
UPDATE LonLat SET name='Democratic Republic of the Congo' WHERE name='Congo - Kinshasa';
UPDATE LonLat SET name='Republic of Congo' WHERE name='Congo - Brazzaville';
UPDATE LonLat SET name='Netherlands Antilles' WHERE name='Curaçao';
UPDATE LonLat SET name='Ivory Coast' WHERE name='Côte d’Ivoire';
UPDATE LonLat SET name='Virgin Islands, US' WHERE name='U.S. Virgin Islands';
UPDATE LonLat SET name='Trinidad and Tobago' WHERE name='Trinidad & Tobago';
UPDATE LonLat SET name='Sao Tome and Principe' WHERE name='São Tomé & Príncipe';
UPDATE LonLat SET name='Saint Vincent' WHERE name='St. Vincent & Grenadines';
UPDATE LonLat SET name='Saint Lucia' WHERE name='St. Lucia';
UPDATE LonLat SET name='Saint Kitts' WHERE name='St. Kitts & Nevis';
UPDATE LonLat SET name='USA' WHERE name='US';
UPDATE noc SET NOC='SGP' WHERE region='Singapore';
 
--There is different name for Moscow in hostcity and athletes:

UPDATE hostcity SET city='Moskva' WHERE city='Moscow';
 
/*For the LonLat table that contains the longitude and the latitude of the countries, we should add the former countries that have 
participated. The longitude and latitude is the same as the countries that are today in their geographic location. Also, for participants
that played in the Olympics independently or as part of the refugee team or there is no information of their country, longitude and 
latitude will be set as 0.*/
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   252,
   (select longitude from LonLat where name='Greece'),
   (select latitude from LonLat where name='Greece'),'Crete');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   251,
   (select longitude from LonLat where name='Zimbabwe'),
   (select latitude from LonLat where name='Zimbabwe'),'Rhodesia');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   253,
   (select longitude from LonLat where name='Australia'),
   (select latitude from LonLat where name='Australia'),'Australasia');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   254,
   (select longitude from LonLat where name='Czech Republic'),
   (select latitude from LonLat where name='Czech Republic'),'Bohemia');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   255,
   (select longitude from LonLat where name='Czech Republic'),
   (select latitude from LonLat where name='Czech Republic'),'Czechoslovakia');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   256,
   (select longitude from LonLat where name='Germany'),
   (select latitude from LonLat where name='Germany'),'East Germany');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   257,
   (select longitude from LonLat where name='Germany'),
   (select latitude from LonLat where name='Germany'),'West Germany');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   258,
   (select longitude from LonLat where name='Germany'),
   (select latitude from LonLat where name='Germany'),'Saar');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   259,
   (select longitude from LonLat where name='Serbia'),
   (select latitude from LonLat where name='Serbia'),'Serbia and Montenegro');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   260,
   (select longitude from LonLat where name='Serbia'),
   (select latitude from LonLat where name='Serbia'),'Kosovo');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   261,
   (select longitude from LonLat where name='Serbia'),
   (select latitude from LonLat where name='Serbia'),'Yugoslavia');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   262,
   (select longitude from LonLat where name='Malaysia'),
   (select latitude from LonLat where name='Malaysia'),'Malaya');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   263,
   (select longitude from LonLat where name='Canada'),
   (select latitude from LonLat where name='Canada'),'Newfoundland');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   264,
   (select longitude from LonLat where name='Yemen'),
   (select latitude from LonLat where name='Yemen'),'North Yemen');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   265,
   (select longitude from LonLat where name='Yemen'),
   (select latitude from LonLat where name='Yemen'),'South Yemen');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   266,
   (select longitude from LonLat where name='Vietnam'),
   (select latitude from LonLat where name='Vietnam'),'South Vietnam');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   267,
   (select longitude from LonLat where name='Syria'),
   (select latitude from LonLat where name='Syria'),'United Arab Republic');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   268,
   (select longitude from LonLat where name='Russia'),
   (select latitude from LonLat where name='Russia'),'Soviet Union');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   269,
   (select longitude from LonLat where name='Russia'),
   (select latitude from LonLat where name='Russia'),'Unified Team');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   270,0,0,'NA');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   271,0,0,'Refugee Olympic Team');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   272,0,0,'Individual Olympic Athletes');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   273,
   (select longitude from LonLat where name='Malaysia'),
   (select latitude from LonLat where name='Malaysia'),'North Borneo');
 
insert into LonLat (Column_1,longitude,latitude,name) values (
   274,
   (select longitude from LonLat where name='Jamaica'),
   (select latitude from LonLat where name='Jamaica'),'West Indies Federation');
