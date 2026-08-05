Table drivers {
  driver_id VARCHAR(30) [pk]
  first_name VARCHAR(100) [not null]
  last_name VARCHAR(100) [not null]
  hire_date DATE
  termination_date DATE
  license_number VARCHAR(50)
  license_state VARCHAR(10)
  date_of_birth DATE
  home_terminal VARCHAR(100)
  employment_status VARCHAR(50)
  cdl_class VARCHAR(10)
  years_experience INT
}

Table trucks {
  truck_id VARCHAR(30) [pk]
  unit_number VARCHAR(50)
  make VARCHAR(50)
  model_year INT
  vin VARCHAR(50)
  acquisition_date DATE
  acquisition_mileage NUMERIC
  fuel_type VARCHAR(20)
  tank_capacity_gallons NUMERIC
  status VARCHAR(50)
  home_terminal VARCHAR(100)
}

Table trailers {
  trailer_id VARCHAR(30) [pk]
  trailer_number VARCHAR(50)
  trailer_type VARCHAR(50)
  length_feet NUMERIC
  model_year INT
  vin VARCHAR(50)
  acquisition_date DATE
  status VARCHAR(50)
  current_location VARCHAR(100)
}

Table customers {
  customer_id VARCHAR(20) [pk]
  customer_name VARCHAR(255) [not null]
  customer_type VARCHAR(50)
  credit_terms_days INT
  primary_freight_type VARCHAR(50)
  account_status VARCHAR(50)
  contract_start_date DATE
  annual_revenue_potential NUMERIC
}

Table routes {
  route_id VARCHAR(30) [pk]
  origin_city VARCHAR(100)
  origin_state VARCHAR(50)
  destination_city VARCHAR(100)
  destination_state VARCHAR(50)
  typical_distance_miles NUMERIC
  base_rate_per_mile NUMERIC
  fuel_surcharge_rate NUMERIC
  typical_transit_days INT
}

Table facilities {
  facility_id VARCHAR(30) [pk]
  facility_name VARCHAR(255) [not null]
  facility_type VARCHAR(50)
  city VARCHAR(100)
  state VARCHAR(50)
  latitude NUMERIC
  longitude NUMERIC
  dock_doors INT
  operating_hours VARCHAR(100)
}

Table loads {
  load_id VARCHAR(30) [pk]
  customer_id VARCHAR(30)
  route_id VARCHAR(30)
  load_date DATE
  load_type VARCHAR(50)
  weight_lbs NUMERIC
  pieces INT
  revenue NUMERIC
  fuel_surcharge NUMERIC
  accessorial_charges NUMERIC
  load_status VARCHAR(50)
  booking_type VARCHAR(50)
}

Table trips {
  trip_id VARCHAR(30) [pk]
  load_id VARCHAR(30)
  driver_id VARCHAR(30)
  truck_id VARCHAR(30)
  trailer_id VARCHAR(30)
  dispatch_date DATE
  actual_distance_miles NUMERIC
  actual_duration_hours NUMERIC
  fuel_gallons_used NUMERIC
  average_mpg NUMERIC
  idle_time_hours NUMERIC
  trip_status VARCHAR(50)
}

Table delivery_events {
  event_id VARCHAR(30) [pk]
  load_id VARCHAR(30)
  trip_id VARCHAR(30)
  facility_id VARCHAR(30)
  event_type VARCHAR(50)
  scheduled_datetime DATE
  actual_datetime DATE
  detention_minutes INT
  on_time_flag BOOLEAN
  location_city VARCHAR(100)
  location_state VARCHAR(50)
}

Table fuel_purchases {
  fuel_purchase_id VARCHAR(30) [pk]
  trip_id VARCHAR(30)
  truck_id VARCHAR(30)
  driver_id VARCHAR(30)
  purchase_date DATE
  location_city VARCHAR(100)
  location_state VARCHAR(50)
  gallons NUMERIC
  price_per_gallon NUMERIC
  total_cost NUMERIC
  fuel_card_number VARCHAR(50)
}

Table truck_maintenance {
  maintenance_id VARCHAR(30) [pk]
  truck_id VARCHAR(30)
  maintenance_date DATE
  maintenance_type VARCHAR(50)
  odometer_reading NUMERIC
  labor_hours NUMERIC
  labor_cost NUMERIC
  parts_cost NUMERIC
  total_cost NUMERIC
  facility_location VARCHAR(100)
  downtime_hours NUMERIC
  service_description VARCHAR(500)
}

Table incidents {
  incident_id VARCHAR(30) [pk]
  trip_id VARCHAR(30)
  truck_id VARCHAR(30)
  driver_id VARCHAR(30)
  incident_date DATE
  incident_type VARCHAR(50)
  location_city VARCHAR(100)
  location_state VARCHAR(50)
  at_fault_flag BOOLEAN
  injury_flag BOOLEAN
  vehicle_damage_cost NUMERIC
  cargo_damage_cost NUMERIC
  claim_amount NUMERIC
  preventable_flag BOOLEAN
  description VARCHAR(500)
}

Table driver_monthly_metrics {
  driver_id VARCHAR(30) [pk]
  month DATE [pk]
  trips_completed INT
  total_miles NUMERIC
  total_revenue NUMERIC
  average_mpg NUMERIC
  total_fuel_gallons NUMERIC
  on_time_delivery_rate NUMERIC
  average_idle_hours NUMERIC
}

Table truck_monthly_performance {
  truck_id VARCHAR(30) [pk]
  month DATE [pk]
  trips_completed INT
  total_miles NUMERIC
  total_revenue NUMERIC
  average_mpg NUMERIC
  maintenance_events INT
  maintenance_cost NUMERIC
  downtime_hours NUMERIC
  utilization_rate NUMERIC
}

Ref: loads.customer_id > customers.customer_id
Ref: loads.route_id > routes.route_id
Ref: trips.load_id > loads.load_id
Ref: trips.driver_id > drivers.driver_id
Ref: trips.truck_id > trucks.truck_id
Ref: trips.trailer_id > trailers.trailer_id
Ref: delivery_events.load_id > loads.load_id
Ref: delivery_events.trip_id > trips.trip_id
Ref: delivery_events.facility_id > facilities.facility_id
Ref: fuel_purchases.trip_id > trips.trip_id
Ref: fuel_purchases.truck_id > trucks.truck_id
Ref: fuel_purchases.driver_id > drivers.driver_id
Ref: truck_maintenance.truck_id > trucks.truck_id
Ref: incidents.trip_id > trips.trip_id
Ref: incidents.truck_id > trucks.truck_id
Ref: incidents.driver_id > drivers.driver_id
Ref: driver_monthly_metrics.driver_id > drivers.driver_id
Ref: truck_monthly_performance.truck_id > trucks.truck_id
