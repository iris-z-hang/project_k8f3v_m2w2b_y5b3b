CREATE TABLE Agent (
    AID char(10) PRIMARY KEY, 
    first_name char(20), 
    last_name char(20)
);
 
CREATE TABLE Player (
    PID char(10) PRIMARY KEY,
    AID char(10) NOT NULL, 
    first_name char(20), 
    last_name char(20), 
    date_of_birth int, 
    health_status char(1), 
    nationality char(3), 
    national_team char(3), 
    position char(20),
    FOREIGN KEY (AID) REFERENCES Agent (AID)
);
 
CREATE TABLE PlayerPlaysForTeam (
    PID char(10), 
    clubID char(10), 
    team_name char(20), 
    year int,
    PRIMARY KEY (PID, clubID, team_name),
    FOREIGN KEY (PID) REFERENCES Player (PID),
    FOREIGN KEY (clubID, team_name) REFERENCES Team,
);
 
CREATE TABLE Sponsor (
    SID char(10) PRIMARY KEY, 
    company_name char(20)
);
 
CREATE TABLE Sponsors (
    SID char(10), 
    clubID char(10),
    PRIMARY KEY (SID, clubID),
    FOREIGN KEY (SID) REFERENCES Sponsor (SID),
    FOREIGN KEY (clubID) REFERENCES Club (clubID)
);


CREATE TABLE Club (
    clubID CHAR(10) PRIMARY KEY,
    club_name CHAR(20),
    country CHAR(20),
    city CHAR(20),
    ownership CHAR(20)
);

CREATE TABLE Team (
    team_name CHAR(20),
    clubID CHAR(10),
    PRIMARY KEY(clubID, team_name),
    FOREIGN KEY(clubID) REFERENCES Club,
   	 ON DELETE CASCADE
);

/* Stadium was decomposed to BCNF */
CREATE TABLE Stadium_PCI (
    postal_code INTEGER PRIMARY KEY,
    city CHAR(20),
);

CREATE TABLE Stadium_PCO (
    postal_code INTEGER PRIMARY KEY,
    country CHAR(20),
);

CREATE TABLE Stadium_PNAS (
    postal_code INTEGER,
    address CHAR(20),
    stad_name CHAR(20),
    seats INTEGER,
    PRIMARY KEY(address, postal_code)
);

CREATE TABLE teamHasStad (
    team_name CHAR(20),
    clubID CHAR(10),
    address CHAR(20),
    postal_code INTEGER
    PRIMARY KEY(team_name, clubID, address, postal_code)
    FOREIGN KEY(team_name, clubID) REFERENCES Team,
    FOREIGN KEY(address, postal_code) REFERENCES Stadium_PNAS
);

CREATE TABLE Game (
    GID CHAR(10) PRIMARY KEY,
    address CHAR(20) NOT NULL,
    postal_code INTEGER NOT NULL,
    date INTEGER,
    referee CHAR(20),
    winner CHAR(10),
    goals_scored INTEGER,
    FOREIGN KEY(address, postal_code) REFERENCES Stadium_PNAS
   	 ON DELETE NO ACTION
   	 ON UPDATE CASCADE
);

CREATE TABLE teamPlaysInGame (
    clubID CHAR(10),
    team_name CHAR(20),
    GID CHAR(10),
    goals INTEGER,
    PRIMARY KEY(clubID, team_name, GID),
    FOREIGN KEY(clubID, team_name) REFERENCES Team,
    FOREIGN KEY(GID) REFERENCES Game
);

/* Coach was decomposed to BCNF */
CREATE TABLE Coach_C1 (
    years_of_experience INT PRIMARY KEY,
    salary INT
);

CREATE TABLE Coach_C2 (
    CID CHAR(10) PRIMARY KEY,
    first_name CHAR(20),
    last_name CHAR(20),
    nationality CHAR(3),
    years_of_experience INT
);

CREATE TABLE Coaches (
    CID CHAR(10) NOT NULL,
    clubID CHAR(10),
    team_name CHAR(20),
    year INT,
    PRIMARY KEY(CID, clubID, team_name),
    FOREIGN KEY(CID) REFERENCES Coach
    FOREIGN KEY(clubID, team_name) REFERENCES Team
);

CREATE TABLE GameIsInStage (
    clubID CHAR(10),
    team_name CHAR(20),
    GID CHAR(10),
    PRIMARY KEY(clubID, team_name, GID),
    FOREIGN KEY(clubID, team_name) REFERENCES Team,
    FOREIGN KEY(GID) REFERENCES Game
);

CREATE TABLE Group (
    SID CHAR(10),
    letter CHAR(1);
    PRIMARY KEY(SID, letter)
    );

CREATE TABLE S1_8 (
    SID CHAR(10) PRIMARY KEY
    );

CREATE TABLE S1_4 (
    SID CHAR(10) PRIMARY KEY
    );

CREATE TABLE S1_2 (
    SID CHAR(10) PRIMARY KEY
    );

CREATE TABLE final (
    SID CHAR(10) PRIMARY KEY
    );

/* Populate tuples: */

INSERT INTO Agent VALUES ("A1", "Mino", "Raiola");
INSERT INTO Agent VALUES ("A2", "Jorge", "Mendes");
INSERT INTO Agent VALUES ("A3", "Jorge", "Messi");
INSERT INTO Agent VALUES ("A4", "Rafaela", "Pimenta");
INSERT INTO Agent VALUES ("A5", "Wanda", "Nara");

INSERT INTO Player VALUES ("P1", "A3", "Lionel", "Messi", 06241987, "H", "Arg", "Arg", "FW");
INSERT INTO Player VALUES ("P2", "A1", "Gianluigi", "Donnarumma", 02251999, "H", "Ita", "Ita", "GK");
INSERT INTO Player VALUES ("P3", "A1", "Matthijs", "de Ligt", 08011999, "H", "Ned", "Ned", "DF");
INSERT INTO Player VALUES ("P4", "A3", "David", "de Gea", 11061990, "H", "Esp", "Esp", "GK");
INSERT INTO Player VALUES ("P5", "A5", "Mauro", "Icardi", 02181993, "H", "Arg", "Arg", "FW");
INSERT INTO Player VALUES ("P6", "A1", "Paul", "Pogba", 03141993, "N", "Fra", "Fra", "MD");
INSERT INTO Player VALUES ("P7", "A2", "Lamine", "Yamal", 12072007, "H", "Esp", "Esp", "FW");

INSERT INTO PlayerPlaysForTeam VALUES ("P1", "CL1", "First team", 2);
INSERT INTO PlayerPlaysForTeam VALUES ("P2", "CL1", "First team", 5);
INSERT INTO PlayerPlaysForTeam VALUES ("P3", "CL3", "First team", 3);
INSERT INTO PlayerPlaysForTeam VALUES ("P4", "CL4", "First team", 4);
INSERT INTO PlayerPlaysForTeam VALUES ("P5", "CL2", "First team", 2);
INSERT INTO PlayerPlaysForTeam VALUES ("P6", "CL5", "First team", 6);
INSERT INTO PlayerPlaysForTeam VALUES ("P7", "CL2", "Atletic", 1);

INSERT INTO Sponsor VALUES ("S1", "Spotify");
INSERT INTO Sponsor VALUES ("S2", "Goat");
INSERT INTO Sponsor VALUES ("S3", "Jeep");
INSERT INTO Sponsor VALUES ("S4", "Qatar Airways");
INSERT INTO Sponsor VALUES ("S5", "Gatorade");

INSERT INTO Sponsors VALUES ("S1", "CL2");
INSERT INTO Sponsors VALUES ("S2", "CL1");
INSERT INTO Sponsors VALUES ("S3", "CL5");
INSERT INTO Sponsors VALUES ("S4", "CL1");
INSERT INTO Sponsors VALUES ("S5", "CL2");

INSERT INTO Club VALUES ("CL1", "PSG", "France", "Paris", "Private");
INSERT INTO Club VALUES ("CL2", "Barcelona", "Spain", "Barcelona", "Public");
INSERT INTO Club VALUES ("CL3", "Bayern", "Germany", "Munich", "Public");
INSERT INTO Club VALUES ("CL4", "Manchester United", "UK", "Manchester", "Private");
INSERT INTO Club VALUES ("CL5", "Juventus", "Italy", "Turin", "Private");

INSERT INTO Team VALUES ("Atletic", "CL2");
INSERT INTO Team VALUES ("First team", "CL2");
INSERT INTO Team VALUES ("First team", "CL1");
INSERT INTO Team VALUES ("First team", "CL3");
INSERT INTO Team VALUES ("First team", "CL4");
INSERT INTO Team VALUES ("First team", "CL5");

INSERT INTO Stadium_PCI VALUES (08028, "Barcelona");
INSERT INTO Stadium_PCI VALUES (80939, "Munich");
INSERT INTO Stadium_PCI VALUES (75016, "Paris");
INSERT INTO Stadium_PCI VALUES (10151, "Turin");
INSERT INTO Stadium_PCI VALUES (08970, "Barcelona");

INSERT INTO Stadium_PCO VALUES (08028, "Spain");
INSERT INTO Stadium_PCO VALUES (80939, "Germany");
INSERT INTO Stadium_PCO VALUES (75016, "France");
INSERT INTO Stadium_PCO VALUES (10151, "Italy");
INSERT INTO Stadium_PCO VALUES (08970, "Spain");

INSERT INTO Stadium_PNAS VALUES (08028, "Arístides Maillol 12", "Camp Nou", 95639);
INSERT INTO Stadium_PNAS VALUES (80939, "25 Werner-Heisenberg-Allee", "Allianz Arena", 75024);
INSERT INTO Stadium_PNAS VALUES (75016, "24 Rue du Commandant Guilbaud", "Parc des Princes", 47929);
INSERT INTO Stadium_PNAS VALUES (10151, "Corso Gaetano Scirea 50", "Allianz Stadium", 41507);
INSERT INTO Stadium_PNAS VALUES (08970, "C. del Mig", "Estadi Johan Cruyff", 6000);

INSERT INTO teamHasStad VALUES ("First team", "CL2", "Arístides Maillol 12", 08028);
INSERT INTO teamHasStad VALUES ("Atletic", "CL2", "C. del Mig", 08970);
INSERT INTO teamHasStad VALUES ("First team", "CL1", "24 Rue du Commandant Guilbaud", 75016);
INSERT INTO teamHasStad VALUES ("First team", "CL3", "25 Werner-Heisenberg-Allee", 80939);
INSERT INTO teamHasStad VALUES ("First team", "CL5", "Corso Gaetano Scirea 50", 10151);

INSERT INTO Game VALUES ("G1", "Arístides Maillol 12", 08028, 09172014, "Wolfgang Stark", "Draw", 2);
INSERT INTO Game VALUES ("G2", "24 Rue du Commandant Guilbaud", 75016, 02242015, "Felix Brych", "Barcelona", 3);
INSERT INTO Game VALUES ("G3", "C. del Mig", 08970, 04152015, "Mark Clattenburg", "PSG", 4);
INSERT INTO Game VALUES ("G4", "25 Werner-Heisenberg-Allee", 80939, 05062015, "Nicola Rizzoli", "Barcelona", 3);
INSERT INTO Game VALUES ("G5", "Corso Gaetano Scirea 50", 10151, 06062015, "Cuneyt Cakir", "Barcelona", 4);

INSERT INTO teamPlaysInGame VALUES ("CL2", "First team", "G1", 1);
INSERT INTO teamPlaysInGame VALUES ("CL2", "First team", "G2", 3);
INSERT INTO teamPlaysInGame VALUES ("CL1", "First team", "G3", 2);
INSERT INTO teamPlaysInGame VALUES ("CL3", "First team", "G4", 0);
INSERT INTO teamPlaysInGame VALUES ("CL5", "First team", "G5", 1);


INSERT INTO Coach_C1 VALUES (12, 37000000);
INSERT INTO Coach_C1 VALUES (08, 12000000);
INSERT INTO Coach_C1 VALUES (22, 10000000);
INSERT INTO Coach_C1 VALUES (01, 14000000);
INSERT INTO Coach_C1 VALUES (10, 25800000);
INSERT INTO Coach_C1 VALUES (2, 15800000);

INSERT INTO Coach_C2 VALUES ("C1", "Kasper", "Hjulmand", "FRA", 12); 
INSERT INTO Coach_C2 VALUES ("C2", "Georgi", "Kondratiev", "BEL", 08);
INSERT INTO Coach_C2 VALUES ("C3", "Edward", "Iordănescu", "DEU", 22);
INSERT INTO Coach_C2 VALUES ("C4", "Francesco", "Calzona", "GRL", 01);
INSERT INTO Coach_C2 VALUES ("C5", "Edgaras", "Jankauskas", "ISL", 10);
INSERT INTO Coach_C2 VALUES ("C6", "Luis", "Enrique", "ESP", 1);

INSERT INTO Coaches VALUES ("C1", "CL2", "Atletic", 10);
INSERT INTO Coaches VALUES ("C2", "CL2", "First team", 1);
INSERT INTO Coaches VALUES ("C3", "CL3", "First team", 3);
INSERT INTO Coaches VALUES ("C4", "CL4", "First team", 20);
INSERT INTO Coaches VALUES ("C5", "CL5", "First team", 7);
INSERT INTO Coaches VALUES ("C6", "CL1", "First team", 2);


INSERT INTO GameIsInStage VALUES ("CL1", "Atletic", "G1");
INSERT INTO GameIsInStage VALUES ("CL2", "First team", "G2");
INSERT INTO GameIsInStage VALUES ("CL3", "First team", "G3");
INSERT INTO GameIsInStage VALUES ("CL4", "First team", "G4");
INSERT INTO GameIsInStage VALUES ("CL5", "First team", "G5");


INSERT INTO Group VALUES ("S1", "A");
INSERT INTO Group VALUES ("S2", "B");
INSERT INTO Group VALUES ("S3", "C");
INSERT INTO Group VALUES ("S4", "D");
INSERT INTO Group VALUES ("S5", "E");
INSERT INTO Group VALUES ("S6", "F");
INSERT INTO Group VALUES ("S7", "G");
INSERT INTO Group VALUES ("S8", "H");

/* stages after groups shouldn’t have more than 1 tuple */

INSERT INTO S1_8 VALUES ("S9");

INSERT INTO S1_4 VALUES ("S10");

INSERT INTO S1_2 VALUES ("S11");

INSERT INTO final VALUES ("S12");

