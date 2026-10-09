import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tipitaka_myanmar/core/theme/settings_provider.dart'; 
import 'package:tipitaka_myanmar/features/home/presentation/pages/home_screen.dart';

class TipitakaApp extends ConsumerWidget {
  const TipitakaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider မှ လက်ရှိ Theme အခြေအနေကို ဖတ်ယူခြင်း
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Tipitaka Myanmar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // isDarkMode variable ပေါ်မူတည်၍ Theme ပြောင်းလဲပေးမည်
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: const HomeScreen(),
    );
  }
}
