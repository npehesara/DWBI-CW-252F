\copy dim_patient FROM 'C:/Users/Lenovo/Documents/DWBI-CW-C/cw-c/warehouse_data/dim_patient.csv' WITH (FORMAT csv, HEADER true);

\copy dim_doctor FROM 'C:/Users/Lenovo/Documents/DWBI-CW-C/cw-c/warehouse_data/dim_doctor.csv' WITH (FORMAT csv, HEADER true);

\copy dim_clinic FROM 'C:/Users/Lenovo/Documents/DWBI-CW-C/cw-c/warehouse_data/dim_clinic.csv' WITH (FORMAT csv, HEADER true);

\copy dim_date FROM 'C:/Users/Lenovo/Documents/DWBI-CW-C/cw-c/warehouse_data/dim_date.csv' WITH (FORMAT csv, HEADER true);

\copy fact_appointment FROM 'C:/Users/Lenovo/Documents/DWBI-CW-C/cw-c/warehouse_data/fact_appointment.csv' WITH (FORMAT csv, HEADER true);