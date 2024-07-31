import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Bloom/src/settings/settings_controller.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the SettingsController using Provider
    final settingsController = Provider.of<SettingsController>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Fixed Height and Opacity
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/logov2.png',
                ),
              ),
            ),
          ),
          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Change to Light Theme
                    settingsController.updateThemeMode(ThemeMode.light);
                  },
                  child: Text('Light Theme'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Change to Dark Theme
                    settingsController.updateThemeMode(ThemeMode.dark);
                  },
                  child: Text('Dark Theme'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
