# Flutter Boilerplate - Repository Pattern

![Repository Pattern Architecture](https://code.kineticastudios.com/kautsar.al.bana/flutter_boilerplate/src/branch/main/docs/architecture.png)

Design patterns are useful templates that help us solve common problems in software design.

And when it comes to app architecture, structural design patterns can help us decide how the different parts of the app are organized.

In this context, we can use the repository pattern to access data objects from various sources, such as a backend API, and make them available as type-safe entities to the domain layer of the app (which is where our business logic lives).

## Table Of Contents

- [Flutter Boilerplate - Repository Pattern](#flutter-boilerplate---repository-pattern)
  - [Table Of Contents](#table-of-contents)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Repository Design Pattern](#repository-design-pattern)

## Requirements

To develop this applications you nedd to read the doccumentations

- [Flutter](https://docs.flutter.dev/get-started/install)
- [Android Studio](https://developer.android.com/studio)
- [XCode](https://developer.apple.com/support/xcode/)
- [Build Runner Library](https://pub.dev/packages/build_runner/install)

## Installation

```shell
$ git clone https://code.kineticastudios.com/kautsar.al.bana/flutter_boilerplate.git <project-name>
$ cd <project-name>
$ flutter pub get && dart run build_runner build --delete-conflicting-outputs
```

## Usage

```shell
$ cd <project-name>
$ flutter pub get && dart run build_runner build --delete-conflicting-outputs
```

- iOS
  You can use the commands `flutter build` and `flutter run` from the app's root
  directory to build/run the app or you can open `ios/Runner.xcworkspace` in Xcode
  and build/run the project as usual.

- Android
  You can use the commands `flutter build` and `flutter run` from the app's root
  directory to build/run the app or to build with Android Studio, open the
  `android` folder in Android Studio and build the project as usual.

  - Generate APKs
    To generate apks, you can use the commands
    ```shell
    $ flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
    ```
    And list all generated files use commands
    ```shell
    $ ls ./build/app/outputs/flutter-apk/
    ```

## Repository Design Pattern

In this context, repositories are found in the data layer. And their job is to:
- isolate domain models (or entities) from the implementation details of the data sources in the data layer.
- convert data transfer objects to validated entities that are understood by the domain layer
- (optionally) perform operations such as data caching.
> The diagram above shows just one of many possible ways of architecting your app. Things will look different if you follow a different architecture such as MVC, MVVM, or Clean Architecture, but the same concepts apply.

Also note how the widgets belong to the presentation layer, which has nothing to do with business logic or networking code.

> If your widgets work directly with key-value pairs from a REST API or a remote database, you're doing it wrong. In other words: do not mix business logic with your UI code. This will make your code much harder to test, debug, and reason about.
