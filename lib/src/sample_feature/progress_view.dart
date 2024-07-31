import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../task_provider.dart';
import 'forests.dart'; // Import the forests.dart file

class ProgressView extends StatelessWidget {
  const ProgressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final completedTaskCount = taskProvider.completedTasks.length;
    final prefsFuture = SharedPreferences.getInstance();

    if (completedTaskCount > 50) {
      // Reset the list
      taskProvider.resetTasks();

      prefsFuture.then((prefs) {
        int imageCount = prefs.getInt('imageCount') ?? 0;
        imageCount += (completedTaskCount - 50); // Add more copies based on excess completed tasks
        prefs.setInt('imageCount', imageCount);
      });
    }

    String backgroundImage = 'assets/image1.png'; // Default background image
    // Select background image based on completedTaskCount
    if (completedTaskCount > 1 && completedTaskCount <= 50) {
      backgroundImage = 'assets/image$completedTaskCount.png'; // Change to a different image
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, 0), // Adjust the offset as needed
              child: Transform.scale(
                scale: 1.1, // Adjust the scale as needed
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover, // Make the image cover the entire screen
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(0, 150), // Move the logo image down by 150 pixels
              child: Transform.scale(
                scale: 1.65, // Increase the scale of the logo image
                child: Image.asset(
                  'assets/logo.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Forests(initialImageCount: 0)),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 400), // Add space at the top
                  Text(
                    '$completedTaskCount',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
