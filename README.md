# Dairy Track

## Overview
The **Dairy Track** mobile app is designed to assist a dairy operation unit in managing the production, distribution, and delivery of dairy products. The app helps manage the supply chain from milk tankers receiving supplies to retail store deliveries. It enables drivers (salesmen) to efficiently navigate assigned routes and manage store visits.

## Features
The app includes the following core functionalities:

### 1. **Landing Page & Basic Login Screen**
   - A landing page for the app.
   - A secure login screen where users can enter their credentials to access the app.

### 2. **Navigation Page**
   - Assists drivers in navigating to their assigned stores using **location coordinates**.
   - Provides directions using **Google Maps**.
   - Drivers can mark their visit as completed, with timestamps for reference.

## Tech Stack
- **Flutter**: Framework used for building the mobile application.
- **Packages Used**:
  - `geolocator`: For fetching the current location of the driver.
  - `get`: For state management and dependency injection.
  - `google_map_polyline_new`: For drawing routes on Google Maps.
  - `google_maps_flutter`: For integrating Google Maps for navigation.
- **Firebase**: Used for storing and managing data such as users (drivers), store information, and visit data.

