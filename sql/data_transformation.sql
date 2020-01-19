-- After (1) importing the data and (2) cleansing them, let's transform them in a way that will help later on with the analysis.

drop table if exists fw;
Go

create table fw(
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Games] [nvarchar](50) NOT NULL,
    [Season] [nvarchar](50) NOT NULL,
    [City] [nvarchar](50) NOT NULL,
    [Year] [int] NOT NULL,
    [Sport] [nvarchar](50) NOT NULL,
	[Event] [nvarchar](100) NOT NULL,
    [Country] [nvarchar](50) NOT NULL,
    [NOC] [nvarchar](50) NOT NULL,
    [countF] INT,
    [countM] INT,
    [countParticipants] INT,
    [countGold] INT,
    [countSilver] INT,
    [countBronze] INT,
    [avgAge] FLOAT(24),
    [avgHeight] FLOAT(24),
    [avgWeight] FLOAT(24),
    [HC] [nvarchar](50),
    [Longitude] FLOAT,
    [Latitude] FLOAT
);
Go

insert into fw (Games,Season,City,Year,Sport,Event,Country,NOC,HC,Longitude,Latitude,avgAge,avgHeight,avgWeight,countParticipants,countM,
countF,countGold,countSilver,countBronze)
SELECT games,Athletes.Season,Athletes.City,Athletes.year,Athletes.sport,event,noc.region,noc.NOC,hostcity.Country,LonLat.Longitude,LonLat.Latitude,Avg(Age) as AvgAge,Avg(Height) as AvgHgt,Avg(Weight) as AvgWgt,
count(Athletes.Name) As Participants,
    sum(case when Sex = 'M' then 1 else 0 end) AS Male,
    sum(case when Sex = 'F' then 1 else 0 end) AS Female,
    sum(case when Medal = 'Gold' then 1 else 0 end) AS Gold,
    sum(case when Medal = 'Silver' then 1 else 0 end) AS Silver,
    sum(case when Medal = 'Bronze' then 1 else 0 end) AS Bronze
FROM Athletes,noc,hostcity,LonLat
Where noc.NOC=athletes.NOC AND Athletes.City=hostcity.City AND noc.NOC=Athletes.NOC AND LonLat.name=noc.region  
GROUP BY Athletes.games,Athletes.season,Athletes.city,Athletes.year,Athletes.sport,Athletes.event,noc.region,noc.NOC,hostcity.Country,LonLat.Longitude,LonLat.Latitude;
Go