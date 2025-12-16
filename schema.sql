-- Table: customers
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_type VARCHAR(50),
    credit_terms_days INTEGER,
    primary_freight_type VARCHAR(50),
    account_status VARCHAR(50),
    contract_start_date DATE,
    annual_revenue_potential NUMERIC(15, 2)
);

-- Table: delivery_events
CREATE TABLE delivery_events (
    event_id VARCHAR(30) PRIMARY KEY,
    load_id VARCHAR(30),
    trip_id VARCHAR(30),
    event_type VARCHAR(50),
    facility_id VARCHAR(30),
    scheduled_datetime TIMESTAMP,
    actual_datetime TIMESTAMP,
    detention_minutes INTEGER,
    on_time_flag BOOLEAN,
    location_city VARCHAR(100),
    location_state VARCHAR(50)
);

-- Table: driver_monthly_metrics
CREATE TABLE driver_monthly_performance (
    driver_id VARCHAR(30),
    month DATE,
    trips_completed INTEGER,
    total_miles NUMERIC(12, 2),
    total_revenue NUMERIC(15, 2),
    average_mpg NUMERIC(6, 2),
    total_fuel_gallons NUMERIC(12, 2),
    on_time_delivery_rate NUMERIC(5, 2),
    average_idle_hours NUMERIC(6, 2),
    PRIMARY KEY(driver_id, month)
);

-- Table: drivers
CREATE TABLE drivers (
    driver_id VARCHAR(30) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    hire_date DATE,
    termination_date DATE,
    license_number VARCHAR(50),
    license_state VARCHAR(10),
    date_of_birth DATE,
    home_terminal VARCHAR(100),
    employment_status VARCHAR(50),
    cdl_class VARCHAR(10),
    years_experience INTEGER
);

-- Table: facilities
CREATE TABLE facilities (
    facility_id VARCHAR(30) PRIMARY KEY,
    facility_name VARCHAR(255) NOT NULL,
    facility_type VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(50),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    dock_doors INTEGER,
    operating_hours VARCHAR(100)
);

-- Table: fuel_purchases
CREATE TABLE fuel_purchases (
    fuel_purchase_id VARCHAR(30) PRIMARY KEY,
    trip_id VARCHAR(30),
    truck_id VARCHAR(30),
    driver_id VARCHAR(30),
    purchase_date DATE,
    location_city VARCHAR(100),
    location_state VARCHAR(50),
    gallons NUMERIC(10,2),
    price_per_gallon NUMERIC(10,3),
    total_cost NUMERIC(12,2),
    fuel_card_number VARCHAR(50)
);

-- Table: loads
CREATE TABLE loads (
    load_id VARCHAR(30) PRIMARY KEY,
    customer_id VARCHAR(30),
    route_id VARCHAR(30),
    load_date DATE,
    load_type VARCHAR(50),
    weight_lbs NUMERIC(12, 2),
    pieces INTEGER,
    revenue NUMERIC(15, 2),
    fuel_surcharge NUMERIC(12, 2),
    accessorial_charges NUMERIC(12, 2),
    load_status VARCHAR(50),
    booking_type VARCHAR(50)
);

-- Table: maintenance_records
CREATE TABLE truck_maintenance (
    maintenance_id VARCHAR(30) PRIMARY KEY,
    truck_id VARCHAR(30),
    maintenance_date DATE,
    maintenance_type VARCHAR(50),
    odometer_reading NUMERIC(12,2),
    labor_hours NUMERIC(6,2),
    labor_cost NUMERIC(12,2),
    parts_cost NUMERIC(12,2),
    total_cost NUMERIC(12,2),
    facility_location VARCHAR(100),
    downtime_hours NUMERIC(6,2),
    service_description TEXT
);

-- Table: routes
CREATE TABLE routes (
    route_id VARCHAR(30) PRIMARY KEY,
    origin_city VARCHAR(100),
    origin_state VARCHAR(50),
    destination_city VARCHAR(100),
    destination_state VARCHAR(50),
    typical_distance_miles NUMERIC(10,2),
    base_rate_per_mile NUMERIC(12,2),
    fuel_surcharge_rate NUMERIC(5,2),
    typical_transit_days INTEGER
);

-- Table: safety_incidents
CREATE TABLE incidents (
    incident_id VARCHAR(30) PRIMARY KEY,
    trip_id VARCHAR(30),
    truck_id VARCHAR(30),
    driver_id VARCHAR(30),
    incident_date DATE,
    incident_type VARCHAR(50),
    location_city VARCHAR(100),
    location_state VARCHAR(50),
    at_fault_flag BOOLEAN,
    injury_flag BOOLEAN,
    vehicle_damage_cost NUMERIC(12,2),
    cargo_damage_cost NUMERIC(12,2),
    claim_amount NUMERIC(12,2),
    preventable_flag BOOLEAN,
    description TEXT
);

-- Table: trailers
CREATE TABLE trailers (
    trailer_id VARCHAR(30) PRIMARY KEY,
    trailer_number VARCHAR(50),
    trailer_type VARCHAR(50),
    length_feet NUMERIC(5, 2),
    model_year INTEGER,
    vin VARCHAR(50),
    acquisition_date DATE,
    status VARCHAR(50),
    current_location VARCHAR(100)
    );

-- Table: trips
CREATE TABLE trips (
    trip_id VARCHAR(30) PRIMARY KEY,
    load_id VARCHAR(30),
    driver_id VARCHAR(30),
    truck_id VARCHAR(30),
    trailer_id VARCHAR(30),
    dispatch_date DATE,
    actual_distance_miles NUMERIC(10,2),
    actual_duration_hours NUMERIC(6,2),
    fuel_gallons_used NUMERIC(10,2),
    average_mpg NUMERIC(6,2),
    idle_time_hours NUMERIC(6,2),
    trip_status VARCHAR(50)
);

-- Table: truck_ultilization_metrics
CREATE TABLE truck_monthly_performance (
    truck_id VARCHAR(30),
    month DATE,
    trips_completed INTEGER,
    total_miles NUMERIC(12, 2),
    total_revenue NUMERIC(15, 2),
    average_mpg NUMERIC(6, 2),
    maintenance_events INTEGER,
    maintenance_cost NUMERIC(12, 2),
    downtime_hours NUMERIC(6, 2),
    utilization_rate NUMERIC(5, 2),
    PRIMARY KEY(truck_id, month)
);

-- Table: trucks
CREATE TABLE trucks (
    truck_id VARCHAR(30) PRIMARY KEY,
    unit_number VARCHAR(50),
    make VARCHAR(50),
    model_year INTEGER,
    vin VARCHAR(50),
    acquisition_date DATE,
    acquisition_mileage NUMERIC(12, 2),
    fuel_type VARCHAR(20),
    tank_capacity_gallons NUMERIC(6, 2),
    status VARCHAR(50),
    home_terminal VARCHAR(100)
);

-- Table: loads
CREATE TABLE loads (
load_id VARCHAR(30) PRIMARY KEY,
customer_id VARCHAR(30),
route_id VARCHAR(30),
load_date DATE,
load_type VARCHAR(50),
weight_lbs NUMERIC(12,2),
pieces INTEGER,
revenue NUMERIC(15,2),
fuel_surcharge NUMERIC(12,2),
accessorial_charges NUMERIC(12,2),
load_status VARCHAR(50),
booking_type VARCHAR(50)
);

-- Table: trips
CREATE TABLE trips (
trip_id VARCHAR(30) PRIMARY KEY,
load_id VARCHAR(30),
driver_id VARCHAR(30),
truck_id VARCHAR(30),
trailer_id VARCHAR(30),
dispatch_date DATE,
actual_distance_miles NUMERIC(10,2),
actual_duration_hours NUMERIC(6,2),
fuel_gallons_used NUMERIC(10,2),
average_mpg NUMERIC(6,2),
idle_time_hours NUMERIC(6,2),
trip_status VARCHAR(50)
);







