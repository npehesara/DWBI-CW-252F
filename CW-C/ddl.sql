CREATE TABLE dim_patient (
    patient_key INTEGER PRIMARY KEY,
    patient_id VARCHAR(20) NOT NULL,
    gender VARCHAR(20),
    date_of_birth DATE,
    district VARCHAR(100)
);

CREATE TABLE dim_doctor (
    doctor_key INTEGER PRIMARY KEY,
    doctor_id VARCHAR(20) NOT NULL,
    doctor_name VARCHAR(150),
    specialty VARCHAR(100)
);

CREATE TABLE dim_clinic (
    clinic_key INTEGER PRIMARY KEY,
    clinic_id VARCHAR(20) NOT NULL,
    clinic_name VARCHAR(150),
    city VARCHAR(100),
    province VARCHAR(100)
);

CREATE TABLE dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    year INTEGER,
    quarter VARCHAR(10),
    month INTEGER,
    month_name VARCHAR(20),
    day INTEGER,
    day_name VARCHAR(20)
);

CREATE TABLE fact_appointment (
    appointment_id VARCHAR(20) PRIMARY KEY,
    patient_key INTEGER NOT NULL,
    doctor_key INTEGER NOT NULL,
    clinic_key INTEGER NOT NULL,
    date_key INTEGER NOT NULL,
    wait_minutes INTEGER,
    consultation_minutes INTEGER,
    fee NUMERIC(10,2),
    FOREIGN KEY (patient_key) REFERENCES dim_patient(patient_key),
    FOREIGN KEY (doctor_key) REFERENCES dim_doctor(doctor_key),
    FOREIGN KEY (clinic_key) REFERENCES dim_clinic(clinic_key),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
);