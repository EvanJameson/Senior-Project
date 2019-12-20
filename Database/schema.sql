###############
##ENTITY SETS##
###############

##Stores information about individual Athletes
CREATE TABLE Athletes(
  AthleteID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Gender ENUM('male','female') NOT NULL,
  Grade ENUM('9th Grade','10th Grade','11th Grade','12th Grade','freshman', 'sophomore','junior','senior') NOT NULL
) AUTO_INCREMENT = 1;

##Stores information about individual Results
CREATE TABLE Results(
  ResultID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Position INT NOT NULL,
  TimeMark TIME,          ##for running events
  DistanceMarkInches INT, ##for field events (storing as inches to easily convert back while also maintaining comparator)
  Pr boolean NOT NULL,
  Sr boolean NOT NULL,
  Wind decimal NOT NULL,
  Sport ENUM('xc','tf') NOT NULL,
  Season VARCHAR(100) NOT NULL
) AUTO_INCREMENT = 1;

##Stores information about individual Schools
CREATE TABLE Schools(
  SchoolID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Mascot VARCHAR(100) NOT NULL,
  Location VARCHAR(100) NOT NULL
) AUTO_INCREMENT = 1;

##Stores information about individual Meets
CREATE TABLE Meets(
  MeetID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Day DATE NOT NULL,
  Sport ENUM('xc','tf') NOT NULL
) AUTO_INCREMENT = 1;

##Stores information about individual Events
CREATE TABLE Events(
  EventID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100)
) AUTO_INCREMENT = 1;

#####################
##RELATIONSHIP SETS##
#####################

##Maintains the Many-to-Many relationship between Athletes and Schools
CREATE TABLE Athletes_Schools(
  AthleteID INT NOT NULL,
  SchoolID INT NOT NULL,
  PRIMARY KEY(AthleteId, SchoolId),
  FOREIGN KEY (AthleteID) REFERENCES Athletes(AthleteID),
  FOREIGN KEY (SchoolID) REFERENCES Schools(SchoolID)
);

##Maintains the Many-to-Many relationship between Athletes and Results
CREATE TABLE Athletes_Results(
  AthleteID INT NOT NULL,
  ResultID INT NOT NULL,
  PRIMARY KEY(AthleteId, ResultId),
  FOREIGN KEY (AthleteID) REFERENCES Athletes(AthleteID),
  FOREIGN KEY (ResultID) REFERENCES Results(ResultID)
);

##Maintains the Many-to-One relationship between Results and Events
CREATE TABLE Results_Events(
  ResultID INT NOT NULL PRIMARY KEY,
  EventID INT NOT NULL,
  FOREIGN KEY (ResultID) REFERENCES Results(ResultID),
  FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

##Maintains the Many-to-One relationship between Results and Meets
CREATE TABLE Results_Meets(
  ResultID INT NOT NULL PRIMARY KEY,
  MeetID INT NOT NULL,
  FOREIGN KEY (ResultID) REFERENCES Results(ResultID),
  FOREIGN KEY (MeetID) REFERENCES Meets(MeetID)
);

##Maintains the Many-to-One relationship between Meets and Schools
CREATE TABLE Meets_Schools(
  MeetID INT NOT NULL PRIMARY KEY,
  SchoolID INT NOT NULL,
  FOREIGN KEY (MeetID) REFERENCES Meets(MeetID),
  FOREIGN KEY (SchoolID) REFERENCES Schools(SchoolID)
);
