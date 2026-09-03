CREATE TABLE dim_student (
    student_key INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    gender VARCHAR(20),
    birth_date DATE
);

CREATE TABLE dim_subject (
    subject_key INTEGER PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL
);

CREATE TABLE dim_stream (
    stream_key INTEGER PRIMARY KEY,
    stream_name VARCHAR(100)
);

CREATE TABLE dim_exam (
    exam_key INTEGER PRIMARY KEY,
    exam_year INTEGER NOT NULL
);

CREATE TABLE dim_syllabus (
    syllabus_key INTEGER PRIMARY KEY,
    syllabus_name VARCHAR(20) NOT NULL
);

CREATE TABLE fact_student_subject (
    fact_key BIGINT PRIMARY KEY,
    student_key INTEGER NOT NULL,
    subject_key INTEGER NOT NULL,
    stream_key INTEGER NOT NULL,
    exam_key INTEGER NOT NULL,
    syllabus_key INTEGER NOT NULL,
    z_score NUMERIC(10,4),
    district_rank INTEGER,
    island_rank INTEGER,
    grade VARCHAR(10),

    CONSTRAINT fk_student
        FOREIGN KEY (student_key)
        REFERENCES dim_student(student_key),

    CONSTRAINT fk_subject
        FOREIGN KEY (subject_key)
        REFERENCES dim_subject(subject_key),

    CONSTRAINT fk_stream
        FOREIGN KEY (stream_key)
        REFERENCES dim_stream(stream_key),

    CONSTRAINT fk_exam
        FOREIGN KEY (exam_key)
        REFERENCES dim_exam(exam_key),

    CONSTRAINT fk_syllabus
        FOREIGN KEY (syllabus_key)
        REFERENCES dim_syllabus(syllabus_key)
);
