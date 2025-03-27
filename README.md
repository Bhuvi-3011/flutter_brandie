# My Flutter App

## Font Information
This project was intended to use the **Oriflame Sans 2.0** font. However, only the *OriflameSans-Oblique* variant was available for use. As a result, the UI may have slight variations from the original design. If the correct font becomes available in the future, it can be updated accordingly.

## Known Issue: Blank Screen on Initial Run

### Description
When launching the Flutter project using `flutter run` in debug mode, the app initially displays a blank screen. However, after performing a hot restart (`R` in terminal or restarting from the IDE), the UI loads correctly without any errors.

### Current Behaviour
- Running `flutter run` (in debug mode) → **Blank screen appears**.
- Performing a **hot restart** (`R` or IDE restart) → **UI loads correctly**.
- Running the project **without debugging** (`flutter run --release`) → **Works fine without issues**.

### Possible Causes
This issue is likely due to:
- Uninitialized state in some widgets or controllers.
- GetX controllers not being initialized properly before rendering.
- Debug mode affecting initial rendering performance.

---

## Assumptions & Custom Improvements
-	The UI implementation follows the provided design as closely as possible.
-	Certain UI/UX improvements have been made based on best practices.
-	The app is structured using clean architecture principles.

## Notes for Brandie Assignment
This project is part of the Brandie Flutter Developer Assignment 2025. The implementation follows the given Figma design and focuses on UI development rather than backend functionality.

If you have any questions, feel free to reach out!



