-- Function to Get All Sessions for a Student*
CREATE FUNCTION GetStudentSessions(studentNRP CHAR(10))
RETURNS TABLE (
    SessionID INT,
    TimeStart TIMESTAMP,
    TimeEnd TIMESTAMP,
    AssistantName VARCHAR(50),
    Presence BOOLEAN
)
BEGIN
    RETURN (
        SELECT 
            ses.ID AS SessionID,
            ses.timeStart AS TimeStart,
            ses.timeEnd AS TimeEnd,
            ass.name AS AssistantName,
            ss.presence AS Presence
        FROM 
            Student_Session ss
            JOIN Session ses ON ss.Session_ID = ses.ID
            JOIN Assistant ass ON ses.Assistant_NRP = ass.NRP
        WHERE 
            ss.Student_NRP = studentNRP
    );
END;

-- Function to Add a New Task to a Course*
CREATE FUNCTION AddTaskToCourse(courseID CHAR(8), taskTitle VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN
    DECLARE msg VARCHAR(100);

    IF (SELECT COUNT(*) FROM Course WHERE ID = courseID) = 0 THEN
        SET msg = 'Course ID does not exist';
    ELSE
        INSERT INTO Task (Course_ID, title) VALUES (courseID, taskTitle);
        SET msg = 'Task added successfully';
    END IF;

    RETURN msg;
END;

-- Procedure to Enroll a Student in a Session*
CREATE PROCEDURE EnrollStudentInSession(
    IN studentNRP CHAR(10),
    IN sessionID INT,
    IN isPresent BOOLEAN
)
BEGIN
    -- Check if the student exists
    IF (SELECT COUNT(*) FROM Student WHERE NRP = studentNRP) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student NRP does not exist';
    END IF;

    -- Check if the session exists
    IF (SELECT COUNT(*) FROM Session WHERE ID = sessionID) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Session ID does not exist';
    END IF;

    -- Check if the student is already enrolled in the session
    IF (SELECT COUNT(*) FROM Student_Session WHERE Student_NRP = studentNRP AND Session_ID = sessionID) > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student is already enrolled in this session';
    END IF;

    -- Enroll the student in the session and mark their presence
    INSERT INTO Student_Session (Student_NRP, Session_ID, presence) 
    VALUES (studentNRP, sessionID, isPresent);
END;