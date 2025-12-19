import 'package:dhikras/features/home/precentation/dhikras_main_screen.dart';
import 'package:dhikras/core/providers/navigation_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 23, 201, 160),
    brightness: Brightness.light
    ),
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark
  )
);

Future <void> main() async {
 WidgetsFlutterBinding.ensureInitialized();  
 await dotenv.load(fileName: "lib/config/secrets.env");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
   const MyApp({super.key});
  static const double designWidth = 402.0;
  static const double designHeight = 874.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final navigationService = ref.read(navigationServiceProvider);
    return 
     ScreenUtilInit(
      designSize: Size(designWidth, designHeight),
       child: MaterialApp(
        navigatorKey: navigationService.navigatorKey,
        darkTheme: darkTheme,
        theme: theme,
        home: const Dhikras(),
           ),
     );
  }
}
