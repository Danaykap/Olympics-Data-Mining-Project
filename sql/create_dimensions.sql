--After (1) importing the data, (2) cleaning the data, (3) transforming the data, it's time to create the dimensions that will be used to create the fact table.

--(1)create Sport dimension
drop table if exists Sport_Dimension;
Create table Sport_Dimension(
    sd_id INT IDENTITY(1,1) PRIMARY KEY,
    sport nvarchar(max) NOT NULL
);
INSERT INTO Sport_Dimension (sport)
SELECT distinct Sport
FROM fw;

--(2)create City dimension
drop table if exists City_Dimension;
Create table City_Dimension(
    ct_id INT IDENTITY(1,1) PRIMARY KEY,
    city nvarchar(50) NOT NULL
);
INSERT INTO City_Dimension (city)
SELECT distinct City
FROM fw;

--(3)create Event dimension
drop table if exists Event_Dimension;
Create table Event_Dimension(
    ev_id INT IDENTITY(1,1) PRIMARY KEY,
    event nvarchar(100) NOT NULL
);
INSERT INTO Event_Dimension (event)
SELECT distinct Event
FROM fw;

--(4)create Region dimension
drop table if exists Country_Dimension;
Create table Country_Dimension(
    cn_id INT IDENTITY(1,1) PRIMARY KEY,
    country nvarchar(50) NOT NULL
);
INSERT INTO Country_Dimension (country)
SELECT distinct Country
FROM fw;

--(5)create Season dimension
drop table if exists Season_Dimension;
Create table Season_Dimension(
    ss_id INT IDENTITY(1,1) PRIMARY KEY,
    season nvarchar(50) NOT NULL
);
INSERT INTO Season_Dimension (season)
SELECT distinct Season
FROM fw;

--(6))create Year dimension
drop table if exists Year_Dimension;
Create table Year_Dimension(
    yr_id INT IDENTITY(1,1) PRIMARY KEY,
    year int NOT NULL
);
INSERT INTO Year_Dimension (year)
SELECT distinct Year
FROM fw;

--(7)create Games dimension
drop table if exists Games_Dimension;
Create table Games_Dimension(
    gm_id INT IDENTITY(1,1) PRIMARY KEY,
    games nvarchar(50) NOT NULL
);
INSERT INTO Games_Dimension (games)
SELECT distinct Games
FROM fw;

--(8)create Host Country dimension
drop table if exists HC_Dimension;
Create table HC_Dimension(
    hc_id INT IDENTITY(1,1) PRIMARY KEY,
    hostCountry nvarchar(50) NOT NULL
);
INSERT INTO HC_Dimension (hostCountry)
SELECT distinct HC
FROM fw;

drop table if exists NOC_Dimension;

drop table if exists GreaterRegion_Dimension;

--(9)create Greater Region dimension
Create table GreaterRegion_Dimension(
    gr_id INT IDENTITY(1,1) PRIMARY KEY,
    sub_region nvarchar(80),
);

INSERT INTO GreaterRegion_Dimension (sub_region)
SELECT Distinct sub_region
FROM Areas;
GO

INSERT INTO GreaterRegion_Dimension (sub_region) VALUES ('None')

--(10)create NOC dimension
Create table NOC_Dimension(
    nc_id INT IDENTITY(1,1) PRIMARY KEY,
    NOC nvarchar(50) NOT NULL,
    gr_id int FOREIGN KEY REFERENCES GreaterRegion_Dimension(gr_id)
);

drop table if exists regtemp;
create table regtemp(
    rgtid INT IDENTITY(1,1) PRIMARY KEY,
    region nvarchar(80),
    noc nvarchar(50) NOT NULL
)

INSERT INTO regtemp
SELECT distinct Country, NOC from fw;

DECLARE @tmax INT;
SET @tmax = (SELECT COUNT(Distinct Country) FROM fw)+1;
DECLARE @t INT = 1;
WHILE @t<=@tmax
BEGIN
    DECLARE @tgrid int;
    SET @tgrid = 
        (SELECT gr_id 
        FROM GreaterRegion_Dimension 
        WHERE sub_region = (
            SELECT sub_region 
            FROM Areas 
            Where Name = (
                SELECT region 
                FROM regtemp 
                WHERE rgtid = @t
            )
        )
    );
    DECLARE @tncid nvarchar(50);
    SET @tncid = (SELECT NOC FROM regtemp WHERE rgtid = @t);
    INSERT INTO NOC_Dimension (NOC,gr_id) VALUES (@tncid,@tgrid);
    SET @t = @t+1;
END

UPDATE NOC_Dimension
SET gr_id = (SELECT gr_id FROM GreaterRegion_Dimension WHERE sub_region = 'None')
WHERE gr_id is null;

GO

drop table if exists regtemp;

GO