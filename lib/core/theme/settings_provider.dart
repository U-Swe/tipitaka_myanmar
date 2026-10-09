import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// Dark Mode ကို ထိန်းချုပ်မည့် Provider (Default အနေဖြင့် Light Mode - false ထားပါမည်)
final themeProvider = StateProvider<bool>((ref) => false);

// Reader Screen အတွက် စာလုံးအရွယ်အစားကို ထိန်းချုပ်မည့် Provider (Default - 16.0)
final fontSizeProvider = StateProvider<double>((ref) => 16.0);
