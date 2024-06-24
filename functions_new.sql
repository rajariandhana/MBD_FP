-- GetTotalSessionsAttended
DELIMITER //

CREATE FUNCTION GetTotalSessionsAttended(studentNRP CHAR(10))
RETURNS INT
BEGIN
    DECLARE totalSessions INT;
    SELECT COUNT(*) INTO totalSessions
    FROM Student_Session
    WHERE Student_NRP = studentNRP AND presence = TRUE;
    RETURN totalSessions;
END //

DELIMITER ;

SELECT GetTotalSessionsAttended('5025221001');

-- GetTotalNotifications
DELIMITER //

CREATE FUNCTION GetTotalNotifications(studentEmail VARCHAR(50))
RETURNS INT
BEGIN
    DECLARE totalNotifications INT;
    SELECT COUNT(*) INTO totalNotifications
    FROM Notification
    WHERE recipientEmail = studentEmail;
    RETURN totalNotifications;
END //

DELIMITER ;

SELECT GetTotalNotifications('');
