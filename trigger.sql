-- 
DELIMITER //

CREATE TRIGGER NotifyAssistant
AFTER INSERT ON Student_Session
FOR EACH ROW
BEGIN
    DECLARE assistantEmail VARCHAR(50);
    DECLARE sessionTimeStart TIMESTAMP;
    DECLARE studentName VARCHAR(50);
    
    SELECT a.email, s.timeStart INTO assistantEmail, sessionTimeStart
    FROM Assistant a
    JOIN Session s ON a.NRP = s.Assistant_NRP
    WHERE s.ID = NEW.Session_ID;

    SELECT name INTO studentName
    FROM Student
    WHERE NRP = NEW.Student_NRP;

    INSERT INTO Notification (recipientEmail, message)
    VALUES (assistantEmail, CONCAT('Student ', studentName, ' with NRP ', NEW.Student_NRP, ' has booked an appointment for session ID ', NEW.Session_ID, ' that starts at ', sessionTimeStart));
END;
//

DELIMITER ;



-- 
DELIMITER //

CREATE TRIGGER NotifyStudent
AFTER INSERT ON Student_Session
FOR EACH ROW
BEGIN
    DECLARE studentEmail VARCHAR(50);
    DECLARE assistantName VARCHAR(50);
    DECLARE assistantNRP CHAR(10);
    DECLARE sessionTimeStart TIMESTAMP;

    SELECT email INTO studentEmail
    FROM Student
    WHERE NRP = NEW.Student_NRP;

    SELECT a.name, a.NRP, s.timeStart INTO assistantName, assistantNRP, sessionTimeStart
    FROM Assistant a
    JOIN Session s ON a.NRP = s.Assistant_NRP
    WHERE s.ID = NEW.Session_ID;

    INSERT INTO Notification (recipientEmail, message)
    VALUES (studentEmail, CONCAT('You have successfully booked the session with ID ', NEW.Session_ID, 
                                 '. The assistant for this session is ', assistantName, 
                                 ' (NRP: ', assistantNRP, '). The session starts at ', sessionTimeStart));
END;
//

DELIMITER ;


