# ⚡️ Flutter Boilerplate

A production-ready, high-performance mobile application starter template built with **Flutter 3.20+**, targeting **Android & iOS**, and engineered following the **`flutter-expert`** architectural standards.

---

## 🏛 Architectural Highlights

- **Architecture:** Feature-First MVVM (Model-View-ViewModel).
- **Type-Safe Routing:** `go_router` + `go_router_builder` with `@TypedGoRoute` annotations.
- **State Management:** Riverpod 3 (`hooks_riverpod`) for global and feature state.
- **Local Widget State:** `flutter_hooks` for localized widget state (controllers, focus, transient animations) without unnecessary controllers.
- **Immutable Models:** `freezed` & `json_serializable` for data classes and sealed unions.
- **Networking:** `dio` configured with custom `LoggingInterceptor` and `ErrorInterceptor`.
- **Logging:** Structured logging using the `logger` package with `AppLogger`.
- **Target Platforms:** Android & iOS only.
- **Rendering & Performance:** Impeller-optimized with `RepaintBoundary`, `const` widgets, and 120 FPS high refresh rate readiness.

---

## 📁 Project Structure

```
lib/
├── app.dart                     # Root application widget & router binding
├── main.dart                    # Application entrypoint
├── core/                        # Shared infrastructure & cross-cutting utilities
│   ├── constants/               # API endpoints and application constants
│   ├── errors/                  # Custom exceptions and failures hierarchy
│   ├── logging/                 # Structured logging using logger package
│   ├── network/                 # Dio client, interceptors, and Result<T> sealed types
│   ├── router/                  # Type-safe GoRouter setup (go_router_builder)
│   └── theme/                   # Material 3 tokens, colors, and ThemeProvider
└── features/                    # Independent feature modules
    ├── chat/                    # Example Feature: Real-time chat & messages
    │   ├── data/                # Data sources, serialization models, repo implementations
    │   ├── domain/              # Pure business contracts & abstract repository interfaces
    │   └── presentation/        # Screens, ViewModels, and reusable UI components
    ├── profile/                 # Example Feature: User profile management
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    └── settings/                # Example Feature: App preferences & theme mode
        └── presentation/
```

---

## 🚀 Getting Started

### 1. Install dependencies
```bash
flutter pub get
```

### 2. Generate Code (Freezed, JSON Serializable, GoRouter)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Run Static Analysis
```bash
flutter analyze
```

### 4. Run Automated Test Suite
```bash
flutter test
```

### 5. Run the Application
- **Android:**
  ```bash
  flutter run -d android
  ```
- **iOS:**
  ```bash
  flutter run -d ios
  ```

---

## 🛠 Renaming / Customizing for a New App

To adapt this boilerplate for your new project:
1. Update `name` and `description` in `pubspec.yaml`.
2. Update `AppConstants.appName` in `lib/core/constants/app_constants.dart`.
3. Update `namespace` and `applicationId` in `android/app/build.gradle.kts`.
4. Update `CFBundleDisplayName` and `CFBundleName` in `ios/Runner/Info.plist`.
5. Run `flutter pub get` and `flutter pub run build_runner build`.
