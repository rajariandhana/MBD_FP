-- 
DELIMITER //
 
CREATE FUNCTION TotalSessionsAttended(studentNRP CHAR(10))
RETURNS INT
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Student_Session
    WHERE Student_NRP = studentNRP AND presence = TRUE;
    RETURN total;
END //
 
DELIMITER ;

SELECT TotalSessionsAttended('');
-- 
DELIMITER //
 
CREATE FUNCTION GetTaskTitle(sessionID INT)
RETURNS VARCHAR(50)
BEGIN
    DECLARE taskTitle VARCHAR(50);
    SELECT Task.title INTO taskTitle
    FROM Task
    JOIN Session ON Task.ID = Session.Task_ID
    WHERE Session.ID = sessionID;
    RETURN taskTitle;
END //
 
DELIMITER ;
SELECT GetTaskTitle(1);