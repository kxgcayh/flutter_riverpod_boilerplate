# ⚡️ Flutter Boilerplate

A production-grade mobile application starter template engineered with **Flutter 3.20+** (Dart 3.x), strictly adhering to the **`flutter-expert`** architectural and performance standards for **Android & iOS**.

---

## 🏛 Core Stack & `flutter-expert` Compliance

| Concern | Package / Technology | `flutter-expert` Role & Best Practice |
| :--- | :--- | :--- |
| **Architecture** | Feature-First MVVM | High-cohesion domain modules with Domain, Data, and Presentation boundaries. |
| **Routing** | `go_router` + `go_router_builder` | Type-safe compile-time route generation via `@TypedGoRoute` and `GoRouteData`. |
| **Global State** | Riverpod 3 (`hooks_riverpod`) | Reactive, testable, and compile-safe state with `Notifier` and `AsyncNotifier`. |
| **Local Widget State** | `flutter_hooks` | Localized UI transient states (controllers, animations, focus) without controller boilerplate. |
| **Immutable Models** | `freezed` + `json_serializable` | Pattern matching, sealed unions, JSON serialization, and `copyWith`. |
| **Networking** | `dio` | Centralized HTTP client, unified timeouts, and custom interceptors. |
| **Logging** | `logger` | Structured `AppLogger` utility replacing `print()`. |
| **Image Caching** | `cached_network_image_ce` | Efficient memory/disk caching, shimmer placeholders, and error fallbacks. |
| **Sensitive Storage** | `flutter_secure_storage` | Hardware-backed keystore/keychain for tokens and auth credentials. |
| **App Preferences** | `shared_preferences` | Key-value store for themes, UI flags, and offline toggles. |
| **Rendering / FPS** | Impeller Engine Ready | `const` constructors, `RepaintBoundary` subtrees, and 120 FPS high refresh optimization. |

---

## 📁 Directory Structure

```
lib/
├── app.dart                     # Root application widget & router binding
├── main.dart                    # Application entrypoint & SharedPreferences bootstrap
├── core/                        # Shared infrastructure & cross-cutting utilities
│   ├── constants/               # API endpoints and application constants
│   ├── errors/                  # Custom exceptions and failures hierarchy
│   ├── logging/                 # Structured logging using logger package
│   ├── network/                 # Dio client, interceptors, and Result<T> sealed types
│   ├── router/                  # Type-safe GoRouter setup (go_router_builder)
│   ├── storage/                 # SecureStorageService & PreferencesService
│   ├── theme/                   # Material 3 tokens, colors, and ThemeProvider
│   └── widgets/                 # AppCachedImage, AppAvatar, and reusable core widgets
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

## 🧩 Architectural Code Examples

### 1. Type-Safe Routing (`go_router_builder`)

```dart
@TypedGoRoute<ChatListRoute>(
  path: '/',
  routes: [
    TypedGoRoute<ChatRoomRoute>(path: 'room/:roomId'),
    TypedGoRoute<ProfileRoute>(path: 'profile'),
    TypedGoRoute<SettingsRoute>(path: 'settings'),
  ],
)
class ChatListRoute extends GoRouteData {
  const ChatListRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ChatListScreen();
}
```

### 2. Result Pattern & Dart 3 Pattern Matching

```dart
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}
class Failure<T> extends Result<T> {
  final AppFailure failure;
  const Failure(this.failure);
}

// Consuming with switch expression
final message = switch (result) {
  Success(data: final rooms) => 'Loaded ${rooms.length} rooms',
  Failure(failure: final err) => 'Error: ${err.message}',
};
```

### 3. Local Transient State with `flutter_hooks`

```dart
class ChatInputField extends HookWidget {
  final ValueChanged<String> onSendMessage;
  const ChatInputField({super.key, required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final isComposing = useState(false);

    return TextField(
      controller: textController,
      onChanged: (text) => isComposing.value = text.trim().isNotEmpty,
    );
  }
}
```

### 4. Image Caching with `cached_network_image_ce`

```dart
AppAvatar(
  imageUrl: user.avatarUrl,
  fallbackName: user.name,
  radius: 26,
  isOnline: true,
)
```

### 5. Secure & Local Storage Separation

```dart
// Sensitive Tokens
final secureStorage = ref.read(secureStorageServiceProvider);
await secureStorage.setAccessToken('jwt_secret_token');

// Non-Sensitive Preferences
final preferences = ref.read(preferencesServiceProvider);
await preferences.setBool(PreferencesService.keyNotificationsEnabled, true);
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

### 3. Run Static Analysis & Tests
```bash
flutter analyze
flutter test
```

### 4. Run the Application
- **Android:**
  ```bash
  flutter run -d android
  ```
- **iOS:**
  ```bash
  flutter run -d ios
  ```
