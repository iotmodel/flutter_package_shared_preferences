import 'package:flutter/material.dart';
import 'package:flutter_package_shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SettingsManager.instance.init();

  runApp(const FlutterPackge());
}

class FlutterPackge extends StatefulWidget {
  const FlutterPackge({super.key});

  @override
  State<FlutterPackge> createState() => _FlutterPackgeState();
}

class _FlutterPackgeState extends State<FlutterPackge> {
  late String themeMode;

  void updateTheme(String mode) {
    setState(() {
      themeMode = mode;
    });
    SettingsManager.instance.themeMode = mode;
  }

  @override
  void initState() {
    super.initState();
    themeMode = SettingsManager.instance.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeMode == 'light' ? ThemeData.light() : ThemeData.dark(),
      home: Home(updateTheme: updateTheme),
    );
  }
}

class Home extends StatelessWidget {
  final Function(String) updateTheme;
  const Home({super.key, required this.updateTheme});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = SettingsManager.instance.themeMode == 'dark';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Light'),
            const SizedBox(width: 8),
            Switch(
              value: isDarkMode,
              onChanged: (bool value) {
                updateTheme(value ? 'dark' : 'light');
              },
            ),
            const SizedBox(width: 8),
            const Text('Dark'),
          ],
        ),
      ),
    );
  }
}
