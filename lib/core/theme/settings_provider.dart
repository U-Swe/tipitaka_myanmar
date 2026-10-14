import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Dark Mode အတွက် Notifier
class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() {
    // App စဖွင့်ချိန်တွင် Hive မှ Data ကို ဖတ်ပါမည် (မရှိပါက false ပါ)
    return Hive.box('settingsBox').get('isDarkMode', defaultValue: false);
  }

  void toggleTheme(bool value) {
    state = value; // UI ကို ပြောင်းလဲစေခြင်း
    Hive.box('settingsBox')
        .put('isDarkMode', value); // Hive သို့ သိမ်းဆည်းခြင်း
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, bool>(ThemeNotifier.new);

// Font Size အတွက် Notifier
class FontSizeNotifier extends Notifier<double> {
  @override
  double build() {
    // App စဖွင့်ချိန်တွင် Hive မှ Font Size ကို ဖတ်ပါမည် (မရှိပါက 16.0 ပါ)
    return Hive.box('settingsBox').get('fontSize', defaultValue: 16.0);
  }

  void updateSize(double value) {
    state = value;
    Hive.box('settingsBox').put('fontSize', value);
  }
}

final fontSizeProvider = NotifierProvider<FontSizeNotifier, double>(
  FontSizeNotifier.new,
);
