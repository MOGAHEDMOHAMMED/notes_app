# Dawin (دوّن) - Note Taking App with GetX

## About The Project
Dawin is a fast, responsive, and intuitive note-taking application built with Flutter.

**Learning Context:** This project is a direct extension and complete refactor of the original Dawin app. The primary goal of this repository is to practically apply and master the **GetX** ecosystem. It transitions from traditional state management (Provider) and native routing to GetX's powerful reactive state management (`Rx`, `Obx`), dependency injection (`Bindings`), and simplified route management.

🔗 **[Original Dawin App (Provider Version) - Click Here](https://github.com/MOGAHEDMOHAMMED/notes_app)**

## Key Features
* **Reactive UI:** Instant UI updates without rebuilding the entire screen using GetX `Obx` and `bindStream`.
* **Authentication:** Secure Email/Password and Google Sign-In powered by Firebase Auth.
* **Real-time Synchronization:** Seamless CRUD operations (Create, Read, Update, Delete) with Cloud Firestore.
* **Smart Storage:** Fast local storage for user preferences using `GetStorage`.
* **Localization:** Built-in multi-language support (Arabic & English) using GetX Translations.
* **Theming:** Dynamic Light and Dark mode switching.
* **Categorization:** Organize notes by custom categories and colors.
* **Archive & Trash:** Safely archive notes or move them to a recoverable deleted items list.

---

## Getting Started

Follow these instructions to set up the project locally on your machine.

### Prerequisites
* Flutter SDK (Latest stable version)
* A Firebase Account (Firebase Console)

### 1. Installation
Clone the repository and install the required packages:
git clone [https://github.com/MOGAHEDMOHAMMED/notes_app_with_getx.git](https://github.com/MOGAHEDMOHAMMED/notes_app_with_getx.git)
cd notes_app_with_getx
flutter pub get
### 2. Firebase Setup
This project requires a connection to your own Firebase project.

#### 1- Install the FlutterFire CLI if you haven't already:
```Bash
dart pub global activate flutterfire_cli
```
#### 2- Run the configuration command at the root of your project:
```Bash
flutterfire configure
```
#### 3- Go to the Firebase Console:
```Bash
flutterfire configure
```
#### 4- Go to the Firebase Console:
  - Authentication: Enable Email/Password and Google providers.
  - Firestore Database: Create a database and set the rules to allow read/write for authenticated users (or start in test mode).
  - Project Settings: Add your SHA-1 fingerprint to your Android app settings to enable Google Sign-In.
### 3. Generate App Icons
To apply the custom app icons configured in flutter_launcher_icons.yaml, run:

```Bash
dart run flutter_launcher_icons
```
### 4. Generate Native Splash Screen
  To apply the native splash screen configured in flutter_native_splash.yaml, run:

```Bash
dart run flutter_native_splash:create
```
### 5. Run the App
You are all set! Run the application on your preferred emulator or physical device:
```Bash
flutter run
```
