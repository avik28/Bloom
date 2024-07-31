import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color statusBarColor = Color.fromARGB(255, 71, 169, 74);
const Color appBarColor = Color.fromARGB(255, 68, 182, 72);
const Color lowerRectangleColor = Color.fromARGB(255, 40, 139, 45);
const double lowerRectangleHeight = 50.0;
const Color lowerRectangleColorDark = Color.fromARGB(255, 60, 121, 66);
const Color appBarColorDark = Color.fromARGB(255, 8, 86, 28);

class Forests extends StatefulWidget {
  final int initialImageCount;

  const Forests({Key? key, required this.initialImageCount}) : super(key: key);

  @override
  _ForestsState createState() => _ForestsState();
}

class _ForestsState extends State<Forests> {
  late SharedPreferences _prefs;
  int _imageCount = 0;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _setStatusBarStyle();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadPrefs(); // Load preferences asynchronously
  }

  Future<void> _loadPrefs() async {
    setState(() {
      _imageCount = _prefs.getInt('imageCount') ?? 0;
    });
  }

  Future<void> _updatePrefs(int count) async {
    await _prefs.setInt('imageCount', count);
  }

  void _setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialImageCount > 50) {
      _imageCount = widget.initialImageCount - 50;
      _updatePrefs(_imageCount);
    }

    List<Widget> images = List.generate(_imageCount, (index) => GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;

            return Dialog(
              backgroundColor: isDarkMode ? Colors.grey[900]! : Colors.white,
              child: Stack(
                children: [
                  Image.asset('assets/image50.png'), // Display the tapped image in the dialog
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(Icons.close, color: isDarkMode ? Colors.white : Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Image.asset('assets/image50.png'), // Display the image in the grid
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0), // Set the preferred size of the app bar
        child: AppBar(
          backgroundColor: appBarColor,
          title: null, // Remove the title
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 40.0, // Set the height of the container below the app bar
            color: appBarColor, // Green color for the rectangle
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Image.asset('assets/logov2.png'), // Centered image inside the green rectangle
                  SizedBox(width: 48), // Add space for the back button
                ],
              ),
            ),
          ),
          Container(
            height: lowerRectangleHeight, // Set the height of the lower rectangle
            color: lowerRectangleColor, // Blue color for the rectangle
            child: Center(
              child: Text(
                'Forests',
                style: TextStyle(fontSize: 20, color: Colors.white), // Text style for the text "Forests"
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 copies of image50 in each row
              ),
              itemBuilder: (context, index) => images[index],
              itemCount: images.length,
            ),
          ),
        ],
      ),
    );
  }
}
