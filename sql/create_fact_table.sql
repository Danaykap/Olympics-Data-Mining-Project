/*After (1) imprting data, (2) cleansing them, (3) transforming them, (4) creating dimensions, the final step before creating 
the cube is to create a fact table.*/

drop table if exists FF;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FF](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Games] int FOREIGN KEY REFERENCES Games_Dimension(gm_id),
    [Season] int FOREIGN KEY REFERENCES Season_Dimension(ss_id),
    [City] int FOREIGN KEY REFERENCES City_Dimension(ct_id),
    [HC] int FOREIGN KEY REFERENCES HC_Dimension(hc_id),
    [lon] FLOAT,
    [lat] FLOAT,
    [Year] int FOREIGN KEY REFERENCES Year_Dimension(yr_id),
    [Sport] int FOREIGN KEY REFERENCES Sport_Dimension(sd_id),
    [Event] int FOREIGN KEY REFERENCES Event_Dimension(ev_id),
    [Country] int FOREIGN KEY REFERENCES Country_Dimension(cn_id),
    [NOC] int FOREIGN KEY REFERENCES NOC_Dimension(nc_id),
	[Greater_Region] int FOREIGN KEY REFERENCES GreaterRegion_Dimension(gr_id),
    [countF] INT,
    [countM] INT,
    [countParticipants] INT,
    [countGold] INT,
    [countSilver] INT,
    [countBronze] INT,
    [avgAge] FLOAT(24),
    [avgHeight] FLOAT(24),
    [avgWeight] FLOAT(24)
);
go

INSERT INTO FF (Games, Season, City, HC, lon, lat, Year, Sport, Event, Country, NOC, Greater_Region, countF, countM, 
countParticipants, countGold, countSilver, countBronze, avgAge, avgHeight, avgWeight)
SELECT 
    Games_Dimension.gm_id,
    Season_Dimension.ss_id,
    City_Dimension.ct_id,
    HC_Dimension.hc_id, fw.Longtitude, fw.Latitude,
    Year_Dimension.yr_id,
    Sport_Dimension.sd_id,
    Event_Dimension.ev_id,
    Country_Dimension.cn_id,
    NOC_Dimension.nc_id,
    GreaterRegion_Dimension.gr_id,
    fw.[countF],fw.[countM],fw.[countParticipants],fw.[countGold],fw.[countSilver],fw.[countBronze],fw.[avgAge],
    fw.[avgHeight],fw.[avgWeight]
FROM 
    fw, NOC_Dimension, GreaterRegion_Dimension, Sport_Dimension, Country_Dimension, HC_Dimension, Games_Dimension, 
    Season_Dimension, Year_Dimension, City_Dimension, Event_Dimension
WHERE
    fw.[NOC] =  NOC_Dimension.NOC AND
    GreaterRegion_Dimension.gr_id = NOC_Dimension.gr_id AND
    fw.[Sport] = Sport_Dimension.sport AND
    fw.[Country] = Country_Dimension.country AND
    fw.[Games] = Games_Dimension.games AND
    fw.[Season] = Season_Dimension.season AND
    fw.[Year] = Year_Dimension.[year] AND
    fw.[City] = City_Dimension.city AND
    fw.[HC] = HC_Dimension.hostCountry AND
    fw.[Event] = Event_Dimension.event;
    