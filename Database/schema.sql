###############
##ENTITY SETS##
###############

# Stores information about individual Athletes
CREATE TABLE Athletes(
  AthleteID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Gender ENUM('Male','Female') NOT NULL,
  Grade ENUM('?','9','10','11','12','17-18','Fr','So','Jr','Sr','Freshman', 'Sophomore','Junior','Senior') NOT NULL
) AUTO_INCREMENT = 1;

# Stores information about individual Schools
CREATE TABLE Schools(
  SchoolID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Mascot VARCHAR(100) NOT NULL,
  City VARCHAR(100) NOT NULL,
  State VARCHAR(100) NOT NULL
) AUTO_INCREMENT = 1;

# Stores information about individual Meets
CREATE TABLE Meets(
  MeetID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Day DATE NOT NULL,
  Sport ENUM('XC','TF') NOT NULL
) AUTO_INCREMENT = 1;

# Stores information about individual Events
CREATE TABLE Events(
  EventID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100)
) AUTO_INCREMENT = 1;

# Stores information about individual Results
CREATE TABLE Results(
  ResultID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Position INT NOT NULL,
  TimeMark TIME(3),       #for running events (3 for millisecond precision)
  DistanceMarkInches DECIMAL(5,2) NOT NULL, #2 after . 3 before #for field events (storing as inches to easily convert back while also maintaining comparator)
  PR boolean NOT NULL,
  SR boolean NOT NULL,
  Wind DECIMAL(2,1) NOT NULL,
  Sport ENUM('XC','TF') NOT NULL,
  SeasonYear VARCHAR(100) NOT NULL,
  SeasonName VARCHAR(100) NOT NULL,
  HandTime BOOLEAN NOT NULL,
  Converted BOOLEAN NOT NULL,
  MarkType ENUM('DQ', 'DNF', 'DNS', 'SCR', 'FS', 'NT', 'ND', 'NM', 'NH', 'FOUL', 'LEGAL') NOT NULL,
  EventID INT NOT NULL,
  MeetID INT NOT NULL,
  FOREIGN KEY (EventID) REFERENCES Events(EventID),
  FOREIGN KEY (MeetID) REFERENCES Meets(MeetID)
) AUTO_INCREMENT = 1;

#####################
##RELATIONSHIP SETS##
#####################

# Maintains the Many-to-Many relationship between Athletes and Schools
CREATE TABLE Athletes_Schools(
  AthleteID INT NOT NULL,
  SchoolID INT NOT NULL,
  PRIMARY KEY (AthleteId, SchoolId),
  FOREIGN KEY (AthleteID) REFERENCES Athletes(AthleteID),
  FOREIGN KEY (SchoolID) REFERENCES Schools(SchoolID)
);

# Maintains the Many-to-Many relationship between Athletes and Results
# Relays make this a MTM realtionship
CREATE TABLE Athletes_Results(
  AthleteID INT NOT NULL,
  ResultID INT NOT NULL,
  PRIMARY KEY (AthleteId, ResultId),
  FOREIGN KEY (AthleteID) REFERENCES Athletes(AthleteID),
  FOREIGN KEY (ResultID) REFERENCES Results(ResultID)
);

# Maintains the Many-to-Many relationship between Meets and Schools
CREATE TABLE Meets_Schools(
  MeetID INT NOT NULL,
  SchoolID INT NOT NULL,
  PRIMARY KEY (MeetID, SchoolID),
  FOREIGN KEY (MeetID) REFERENCES Meets(MeetID),
  FOREIGN KEY (SchoolID) REFERENCES Schools(SchoolID)
);
