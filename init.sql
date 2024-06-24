DROP TABLE IF EXISTS Student_Session, Session, Task, Course, Student, Assistant, Notification;
CREATE TABLE Student (
    NRP CHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    password VARCHAR(50)
);

CREATE TABLE Assistant (
    NRP CHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    password VARCHAR(50)
);

CREATE TABLE Course (
    ID CHAR(8) PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Task (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Course_ID CHAR(8),
    title VARCHAR(50),
    FOREIGN KEY (Course_ID) REFERENCES Course(ID)
);

CREATE TABLE Session (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    timeStart TIMESTAMP,
    timeEnd TIMESTAMP NULL,
    Assistant_NRP CHAR(10),
    Task_ID INT,
    FOREIGN KEY (Assistant_NRP) REFERENCES Assistant(NRP),
    FOREIGN KEY (Task_ID) REFERENCES Task(ID)
);

CREATE TABLE Student_Session (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Student_NRP CHAR(10),
    Session_ID INT,
    presence BOOLEAN,
    FOREIGN KEY (Student_NRP) REFERENCES Student(NRP),
    FOREIGN KEY (Session_ID) REFERENCES Session(ID)
);

CREATE TABLE Notification (
    ID INT  PRIMARY KEY,
    recipientEmail varchar(50),
    message varchar(100)
);