# Expoze

Minimalist, gamified exposure therapy in your pocket: small actions, steady courage, private by design.

## About The Project

Expoze is a Flutter mobile application inspired by Exposure Therapy, a practical subset of Cognitive Behavioral Therapy (CBT). It helps users gradually reduce avoidance behavior by turning intimidating situations into manageable, repeatable micro-steps.

The experience is built around three principles:

- Privacy-First: Sensitive personal context stays on the device whenever possible.
- Micro-Habits: Large fears are broken into small, achievable actions through a fear hierarchy approach.
- Calming UX: A minimalist Sage Green visual language designed to reduce stress and cognitive load.

## Key Features

- Intelligent Onboarding: Captures anxiety focus areas (for example, public speaking or meeting strangers) and personal context.
- Dynamic Task Engine: Generates and adapts upcoming micro-tasks based on user feedback and completion behavior.
- SUDS-Aware Progression: Difficulty evolves according to Subjective Units of Distress Scale trends.
- Gamified Motivation: Courage levels, XP, and streak-oriented momentum loops.
- Reflection-Oriented Flow: Supports progressive confidence building instead of all-or-nothing challenges.

## Tech Stack

- Flutter: Cross-platform mobile framework.
- BLoC / Cubit: Predictable state management.
- Isar Database: High-performance, type-safe local persistence.
- On-Device LLM
- Localization: Flutter l10n + intl.
- Code Generation: Freezed, Json Serializable, Isar Generator, Build Runner.

## Architecture

Expoze follows a Feature-First Clean Architecture structure.

- core/: Shared theme, constants, utilities, reusable widgets.
- data/: Models, repositories, local AI service, local database service.
- features/: Feature modules such as splash, onboarding, tasks, and profile.

This structure keeps domain logic modular, testable, and scalable while allowing teams to iterate feature-by-feature.

## Getting Started

### Prerequisites

- Flutter SDK (stable)
- Dart SDK (bundled with Flutter)
- Android Studio or Xcode for device/simulator targets

### Installation

1. Clone the repository.
2. Install dependencies:

```bash
flutter pub get
```

3. Run code generation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. (Optional) Watch mode for active development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

5. Run the app:

```bash
flutter run
```

### Quality Checks

```bash
flutter analyze
flutter test
```

## Privacy & Security

Expoze is designed around privacy-sensitive mental health workflows:

- On-device AI processing is the primary direction to avoid sending fear profiles and behavioral data to external servers.
- User progress and task context are stored locally with Isar.
- The app is built to minimize unnecessary data exposure across the stack.

## Screenshots

The UI follows a minimalist Sage Green aesthetic with a calming visual rhythm.

- Onboarding (Fear Focus Selection)
- Daily Tasks (Adaptive Micro-Challenges)
- Progress (XP, Courage Level, Anxiety Trend)
- Profile (Therapy Rhythm and Reflection Archive)

> Add screenshots/gifs here once visual assets are exported.

## Roadmap

- Full on-device LLM task generation flow with offline fallback strategy.
- Expanded analytics for anxiety trend visualization.
- Personalized challenge pacing based on recent confidence trajectory.
- Production-ready local persistence migrations and backup strategy.

## Contributing

Contributions are welcome. Please open an issue or discussion before large architectural changes.

## License

Add your preferred license here (for example, MIT).
