import 'package:flutter/material.dart';
import 'package:my_flutter_project/core/routes/app_routes.dart';
import 'package:my_flutter_project/core/routes/route_generator.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';
import 'package:my_flutter_project/providers/language_provider.dart';
import 'package:my_flutter_project/views/screens/active_notes_screen.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'views/widget/app_drawer.dart';
import 'views/widget/navigation_bar_bottom.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, languageProvider, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes App',
          //localizations settings:
          locale: languageProvider.currentLocale,
          supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          //theme settings:
          themeMode: themeProvider.themeMode,

          //light theme colors
          theme: ThemeData(
            brightness: Brightness.light,
            cardTheme: CardThemeData(color: Colors.amber[50]),
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              secondary: Colors.orange,
              surface: Colors.white,
            ),

            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 0,
            ),

            drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            cardTheme: const CardThemeData(
              color: Color.fromARGB(255, 139, 102, 102),
            ),
            colorScheme: const ColorScheme.dark(
              primary: Colors.indigo,
              secondary: Colors.amber,
              surface: Color(0xFF1E1E1E),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1F1F1F),
              foregroundColor: Colors.white,
            ),
            drawerTheme: const DrawerThemeData(
              backgroundColor: Color(0xFF2D2D2D),
            ),
          ),
          initialRoute: AppRoutes.createUser,
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  TextEditingController mycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.surface,
        ),
        padding: const EdgeInsets.all(8.0),
        child: ActiveNoteScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        //   Provider.of<NotesProvider>(
        //   context,
        //   listen: false,
        // ).addNote('', '', DateTime.now(), DateTime.now());
        },
      ),

      bottomNavigationBar: NavigationBarBottom(),
    );
  }
}
