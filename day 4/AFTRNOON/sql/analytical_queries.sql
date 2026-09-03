-- 1. Average Z-score by Stream
SELECT 
    s.stream_name,
    AVG(f.z_score) AS average_z_score
FROM fact_student_subject f
JOIN dim_stream s 
    ON f.stream_key = s.stream_key
GROUP BY s.stream_name
ORDER BY average_z_score DESC;


-- 2. Average Z-score by Subject
SELECT 
    s.subject_name,
    AVG(f.z_score) AS average_z_score
FROM fact_student_subject f
JOIN dim_subject s 
    ON f.subject_key = s.subject_key
GROUP BY s.subject_name
ORDER BY average_z_score DESC;


-- 3. Grade Distribution by Subject
SELECT 
    s.subject_name,
    f.grade,
    COUNT(*) AS student_count
FROM fact_student_subject f
JOIN dim_subject s 
    ON f.subject_key = s.subject_key
GROUP BY s.subject_name, f.grade
ORDER BY s.subject_name, student_count DESC;


-- 4. Average Z-score by Gender
SELECT 
    st.gender,
    AVG(f.z_score) AS average_z_score
FROM fact_student_subject f
JOIN dim_student st 
    ON f.student_key = st.student_key
GROUP BY st.gender;


-- 5. Average Z-score by Syllabus
SELECT 
    sy.syllabus_name,
    AVG(f.z_score) AS average_z_score
FROM fact_student_subject f
JOIN dim_syllabus sy 
    ON f.syllabus_key = sy.syllabus_key
GROUP BY sy.syllabus_name;


-- 6. Number of Students by Stream
SELECT 
    s.stream_name,
    COUNT(DISTINCT f.student_key) AS student_count
FROM fact_student_subject f
JOIN dim_stream s 
    ON f.stream_key = s.stream_key
GROUP BY s.stream_name
ORDER BY student_count DESC;
