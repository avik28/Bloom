import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'settings/settings_controller.dart';
import 'sample_feature/tasks_view.dart';
import 'sample_feature/progress_view.dart';
import 'sample_feature/menu_view.dart';

const Color customTabColorLight = Color.fromARGB(255, 88, 204, 100);
const Color customTabColorDark = Color.fromARGB(255, 60, 121, 66);
const Color statusBarColorLight = Colors.green; // Light theme status bar color
const Color statusBarColorDark = Color.fromARGB(255, 8, 86, 28); // Dark theme status bar color

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Determine status bar color based on theme mode
    Color statusBarColor = settingsController.themeMode == ThemeMode.dark
        ? statusBarColorDark
        : statusBarColorLight;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness:
          settingsController.themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
    ));

    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
              backgroundColor: statusBarColorLight,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: statusBarColorLight,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            tabBarTheme: const TabBarTheme(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2, color: Colors.white),
              ),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
              backgroundColor: statusBarColorDark,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: statusBarColorDark,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            tabBarTheme: const TabBarTheme(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2, color: Colors.white),
              ),
            ),
          ),
          themeMode: settingsController.themeMode,
          home:const MainTabView(),
        );
      },
    );
  }
}

class MainTabView extends StatelessWidget {
  const MainTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color tabBackgroundColor = Theme.of(context).brightness == Brightness.dark
        ? customTabColorDark
        : customTabColorLight;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: null,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: Theme.of(context).appBarTheme.elevation,
          systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Column(
              children: [
                SizedBox(height: 0.5),
                Container(
                  height: 40,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: Center(
                    child: Image.asset('assets/logov2.png'),
                  ),
                ),
                Container(
                  color: tabBackgroundColor,
                  child: const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          'Tasks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'YourCustomFont', // Replace 'YourCustomFont' with your desired font family
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'YourCustomFont', // Replace 'YourCustomFont' with your desired font family
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Menu',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'YourCustomFont', // Replace 'YourCustomFont' with your desired font family
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            TasksView(),
            ProgressView(),
            MenuView(),
          ],
        ),
      ),
    );
  }
}
