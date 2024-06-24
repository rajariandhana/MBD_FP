-- 
DELIMITER //
CREATE PROCEDURE CreateSession(
    IN assistantNRP CHAR(10),
    IN startTime TIMESTAMP,
    IN taskID CHAR(8)
)
BEGIN
    DECLARE newSessionID INT;

    INSERT INTO Session (timeStart, Assistant_NRP, Task_ID)
    VALUES (startTime, assistantNRP, taskID);

    SET newSessionID = LAST_INSERT_ID();

    SELECT newSessionID AS SessionID;
END;
//
DELIMITER ;

CALL CreateSession(5025211002, '2024-07-01 14:00:00', 1);
CALL CreateSession(5025211003, '2024-07-01 14:00:00', 2);

-- 
DELIMITER //

CREATE PROCEDURE BookSession(
    IN studentNRP CHAR(10),
    IN sessionID INT
)
BEGIN
    DECLARE studentCount INT;
    DECLARE bookingError VARCHAR(100);

    SELECT COUNT(*) INTO studentCount
    FROM Student_Session
    WHERE Session_ID = sessionID;

    IF studentCount >= 5 THEN
        SET bookingError = CONCAT('The session with ID ', sessionID, ' is fully booked and cannot accept more students.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = bookingError;
    ELSE
        INSERT INTO Student_Session (Student_NRP, Session_ID, presence)
        VALUES (studentNRP, sessionID, FALSE);
    END IF;
END;
//

DELIMITER ;

-- no more than 5 student
CALL BookSession('5025221001', 21);
CALL BookSession('5025221002', 21);
CALL BookSession('5025221003', 21);
CALL BookSession('5025221004', 21);
CALL BookSession('5025221005', 21);
CALL BookSession('5025221006', 21);

CALL BookSession('5025221007', 22);
CALL BookSession('5025221008', 22);
CALL BookSession('5025221009', 22);