--University enrollment database code by Zachary Reid
CREATE TABLE students (
    id INT IDENTITY PRIMARY KEY, --IDENTITY has the use of auto incriment
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    school_enrollment_date DATE
);

CREATE TABLE professors (
    id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE courses (
    id INT IDENTITY PRIMARY KEY,
    course_name VARCHAR(100),
    course_description TEXT,
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(id)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Inserting the data for the tables:
-- Info for the students
INSERT INTO students (first_name, last_name, email, school_enrollment_date) VALUES
('John', 'Doe', 'john.doe@gmail.com', '2022-09-01'),
('Jane', 'Deer', 'jane.deer@gmail.com', '2021-09-01'),
('Alice', 'Fawn', 'alice.fawn@gmail.com', '2023-01-15'),
('Bobby', 'Buck', 'bob.buck@gmail.com', '2020-08-20'),
('Charlie', 'Roe', 'charlie.roe@gmail.com', '2022-05-05');

-- Professor information
INSERT INTO professors (first_name, last_name, department) VALUES
('Gordon', 'Freeman', 'Physics'),
('Melissa', 'Hathaway', 'Mathematics'),
('Dominic', 'Wily', 'Computer Science'),
('Louie', 'Olimar', 'Biology');

-- Info for courses
INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'General Physics', 1),
('Calculus I', 'Intro to Calculus', 2),
('Web Design', 'Front-end Web Development', 3);

-- Enrollment information
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2022-09-05'),
(1, 2, '2022-09-06'),
(2, 1, '2021-09-10'),
(3, 3, '2023-01-20'),
(4, 2, '2020-08-25'),
(5, 1, '2022-05-10');


-- Getting the full name of the students in Physics 101
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM students
WHERE id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = (
        SELECT id FROM courses WHERE course_name = 'Physics 101'
    )
);

-- Making a list of every course while stating the name of the professor teaching each course
SELECT c.course_name, CONCAT(p.first_name, ' ', p.last_name) AS professor_full_name
FROM courses c
JOIN professors p ON c.professor_id = p.id;

-- Showing every course that has a student enrolled to it
SELECT DISTINCT c.course_name
FROM courses c
JOIN enrollments e ON c.id = e.course_id;

-- Updating the email of a student
UPDATE students
SET email = 'john.newemail@gmail.com'
WHERE id = 1;

-- Removing a student from a course
DELETE FROM enrollments
WHERE student_id = 1 AND course_id = 2;


