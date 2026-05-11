# Reactive Prayer Box Application

## Overview
This is a reactive Flutter-based mobile and web application designed to allow users to create, manage, and reflect on personal prayer requests.
The application supports:
- Adding new prayer requests
- Viewing active prayer requests
- Marking prayers as answered
- Viewing answered prayers
- Persisting data locally between sessions
- Fetching daily scripture dynamically from an external Bible API
- Responsive navigation via a drawer-based menu


## Technologies Used
- Flutter
- Dart
- GetX (state management and routing)
- SharedPreferences (local persistence)
- HTTP (API communication)
- Intl (date formatting)


## Architecture
The application follows a layered architecture:
- Data layer (models and services)
- Controllers (state logic using GetX)
- UI layer (screens and reusable widgets)
- Centralised routing
- Global theming

All persistent data is stored locally and restored upon restart.


## How to Run
1. Ensure Flutter SDK is installed.
   Ensure you have an emulator installed in Android Studios 

2. Run:
   flutter pub get

3. To launch on emulator:
### Open a separate terminal in your powershell
   flutter emulators
   flutter emulators --launch <emulator_name>
   
   flutter run 
   # or 
   flutter run -d android

4. To launch on web:
### Open a separate terminal in your powershell
   flutter run -d <browser> --web-port 5000

   # e.g.
   flutter run -d edge --web-port 5000

5. To run on both simultaneously:
### Open two terminals in your powershell
# terminal 1
   flutter run -d android 

# terminal 2
   flutter run -d edge --web-port 5000


## Project Structure
All source code is located in the `lib/` directory.
The application uses named routing and reactive state management via GetX.


## Deployment
The application is deployed at:
[localhost](http://localhost:5000/)


## Notes
- No binary files are included.
- All data persists locally.
- The logout feature is intentionally inactive.
- There is no user authentication, hence the logout feature being inactive and only for show