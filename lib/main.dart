import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are initialized
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => settingsController,
        ),
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
      ],
      child: MyApp(settingsController: settingsController),
    ),
  );
}
