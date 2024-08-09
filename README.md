# FisherMap PH Mobile Application

> This is a Special Problem Topic of John Rommel B. Octavo

### Installation:

1. Make sure to install necessary modules and package in Flutter. On the main directory run this command: $ `flutter pub get`
2. To check for necessary modules to run the app run this command: $ `flutter doctor`
3. The server must be started first before running the app. [This is the server repository](https://github.com/jirrroooo/FisherMapPH-Website-and-Server).
4. On the `\lib\data\credentials.dart` change the `API` key to the server url. 
4. To run the flutter app run this command: $ `flutter run`


### Mobile App Sample Credential:

Email Address: `user@gmail.com`

Password: `useruser` 


## Details:

The FisherMap PH mobile application was developed using the Flutter framework. It is an open-source UI software development toolkit that is used to develop cross-platform applications.

Bloc Framework was used for the state management of the mobile application. It is essential for separating the business logic from the user interface components. The separation of concerns using the Bloc pattern makes the code more readable and structured.

The Flutter secure storage is used to store the JWT token. This will be used for the authorization and securing of routes in the mobile application. The mobile application checks for the token in the Flutter secure storage, if the token is present and it is valid, the user can log in to the account. However, if it is not present or the token is invalid, the user will be redirected to the login page.

![Login Page of the Mobile Application](/src/login_page "Login Page of the Mobile Application")

The map feature in the mobile application uses Flutter map and the Geolocator. Flutter Map uses OpenStreetMap similar to the web application. The Geolocator is crucial in determining the current position of the user. Location and alert monitoring were implemented every 15 minutes. When the fisherfolk are within the radius of an alert the frequency of the monitoring becomes every 5 minutes. 

![Sea Map Page of the Mobile Application](/src/sea_map "Sea Map Page of the Mobile Application")

When the fisherfolk are within the radius of the alert, a push notification will be sent to the fisherfolk to inform them of the possible risk. Alert notifications will be sent at a five-minute interval. 

![Alert Notification Interface](/src/alert_notification "Alert Notification Interface")

One of the important parts of feature in the mobile application is the sending of distress messages. The mobile application has a dedicated page for sending distress signals. The interface of the distress signal is patterned so that the fisherfolk can select what type of emergency. Moreover, they can specify it further using a dedicated message box. The essential information, especially the current location and contacts of the fisherfolk was sent to administrators for proper action. The mobile application also logs the distress call information in each successful report for tracing and validation purposes. A dedicated success page was also implemented to assure the fisherfolk that the distress call was sent.

The user sends a distress signal to the administrators and the administrators forward the distress call to the concerned unit for rescue operation.

![Send Distress Call Page](/src/distress_page "Send Distress Call Page")

Aside from the bottom navigation, the mobile application also uses a drawer to navigate to other pages. The profile page can be accessed using the drawer. The simplified profile details are shown in it. The settings and other mobile application details are specified in the pages of the drawer.  The logout button is also located on it for easy navigation.

![Drawer of the Mobile Application.](/src/drawer "Drawer of the Mobile Application")

