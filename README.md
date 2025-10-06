# Notes App - Learning MVVM Architecture in Flutter

This project is a simple Notes App built with Flutter to demonstrate and learn the **MVVM (Model-View-ViewModel)** architecture pattern.

---

## Purpose
The main goal of this project is to understand how to structure a Flutter app using MVVM principles, focusing on:
- Separation of concerns
- Reactive state management
- Clean code organization

## Architecture Overview
- **Model:** Defines data structures for notes, such as `Note`.
- **View:** Flutter UI screens for login, signup, listing, and adding notes.
- **ViewModel:** Manages UI state, exposes data streams, and handles user interactions with `ChangeNotifier` to update the views.
- **Repository:** Handles data access and persistence using Firebase (Firestore + Auth).

## Key Concepts Learned
- Using `ChangeNotifier` for state management without third-party packages
- Reactive UI updates via `notifyListeners()`
- Handling asynchronous data with `StreamBuilder` and `FutureBuilder`
- Clean separation of UI logic, business logic, and data layer
- Firebase Authentication and Firestore integration

## How to Run
1. Set up Firebase project and enable Firestore and Authentication.
2. Replace Firebase configuration in the project.
3. Run `flutter pub get`.
4. Run the app: `flutter run`.

---

## Conclusion
This project serves as a beginner-friendly example to explore MVVM architecture in Flutter, encouraging good practices like separation of concerns, reactive programming, and clean architecture.
