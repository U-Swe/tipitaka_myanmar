import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider များမှ လက်ရှိ State ကို ဖတ်ယူခြင်း
    final isDarkMode = ref.watch(themeProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          // Theme ပြောင်းရန် Toggle Switch (Dark Mode / Normal Mode)[cite: 1]
          SwitchListTile(
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('နေ့/ည အလင်းအမှောင် ပြောင်းရန်'),
            value: isDarkMode,
            activeThumbColor: Colors.brown,
            onChanged: (value) {
              // Toggle Switch နှိပ်လိုက်ပါက Theme Provider ကို Update လုပ်ပါမည်
              ref.read(themeProvider.notifier).state = value;
            },
            secondary: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.brown,
              size: 32,
            ),
          ),

          const Divider(height: 32),

          // စာလုံးအရွယ်အစား ချိန်ညှိရန် Slider (Font Size)[cite: 1]
          ListTile(
            title: const Text(
              'Font Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('စာလုံးအရွယ်အစား အကြီး/အသေး ချိန်ညှိရန်'),
            trailing: const Icon(
              Icons.format_size,
              color: Colors.brown,
              size: 32,
            ), // secondary အစား trailing ဟု ပြောင်းပါ
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                const Text('A', style: TextStyle(fontSize: 14)),
                Expanded(
                  child: Slider(
                    value: fontSize,
                    min: 14.0,
                    max: 30.0,
                    divisions: 8,
                    activeColor: Colors.brown,
                    label: fontSize.round().toString(),
                    onChanged: (value) {
                      // Slider ရွှေ့လိုက်ပါက Font Size Provider ကို Update လုပ်ပါမည်
                      ref.read(fontSizeProvider.notifier).state = value;
                    },
                  ),
                ),
                const Text(
                  'A',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // နမူနာ စာသား ပြသခြင်း
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'နမော တဿ ဘဂဝတော အရဟတော သမ္မာသမ္ဗုဒ္ဓဿ',
                style: TextStyle(fontSize: fontSize, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
