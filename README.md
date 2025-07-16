# Bloom – Forest-Themed Dynamic To-Do App

**Bloom** is a Flutter-based mobile application that combines productivity with nature-inspired visuals. As users complete tasks, they watch a virtual forest grow—offering a gamified and rewarding task management experience designed to encourage daily goal completion.

## Features

- Add, edit, and delete to-do tasks
- Mark tasks as completed to grow a digital forest
- Smooth and animated UI for an engaging experience
- Visual feedback to motivate consistent task completion
- Local data persistence using shared preferences 
- Minimalist, distraction-free user interface

## Tech Stack

- **Flutter** – Cross-platform app development framework
- **Dart** – Programming language used by Flutter
- **State Management** –  `Provider`
- **Local Storage** – `shared_preferences`

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/avik28/Bloom.git
   ```

2. Navigate to the project folder:

   ```bash
   cd Bloom
   ```

3. Get all the dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

   Ensure you have a connected device or emulator running.

## Project Structure

```
lib/
├── main.dart                  # Application entry point
├── models/                    # Task model definitions
├── screens/                   # UI screens (e.g., home, add task)
├── widgets/                   # Reusable widgets (task tile, forest visuals)
├── services/                  # Data handling logic (local storage)
└── utils/                     # Constants, themes, helpers

assets/
├── images/                    # Static visual assets (e.g., trees)
└── animations/                # Lottie or animation files

pubspec.yaml                   # Project metadata and dependencies
```

## How It Works

- The user adds tasks via an intuitive interface.
- Each completed task triggers visual growth in the forest.
- The forest acts as a metaphor for daily productivity.
- Data is stored locally to preserve user progress across sessions.
- Optional resets allow users to clear all tasks and restart their forest.

## Use Cases

- Daily habit tracking with visual motivation
- Gamified productivity tool for students and professionals
- Encouraging mindfulness and routine through visual reward

Developed by [Sai Avinash Komaragiri](https://github.com/avik28)
