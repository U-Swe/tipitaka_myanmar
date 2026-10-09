import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

void main() async {
  // Flutter Widgets များကို Initialize လုပ်ရန်
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Database (Local Storage) ကို Initialize လုပ်ရန်
  await Hive.initFlutter();

  // Settings သို့မဟုတ် Favorites အတွက် Box များဖွင့်ရန် (ဥပမာ)
  await Hive.openBox('settingsBox');

  // Provider Scope ဖြင့် App ကို ပတ်ထားရန် (Riverpod အသုံးပြုရန်)
  runApp(const ProviderScope(child: TipitakaApp()));
}
