import 'package:flutter/material.dart';

import 'pitaka_detail_screen.dart';
import '../widgets/side_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ပိဋကတ် ၃ ပုံ'),
        centerTitle: true,
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      drawer:
          const SideDrawer(), // အပေါ်တွင် ရေးခဲ့သော Drawer ကို ချိတ်ဆက်ခြင်း
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPitakaCard(context, 'ဝိနည်းပိဋကတ်', Icons.menu_book),
          _buildPitakaCard(context, 'သုတ္တန္တပိဋကတ်', Icons.auto_stories),
          _buildPitakaCard(context, 'အဘိဓမ္မပိဋကတ်', Icons.library_books),
        ],
      ),
    );
  }

  // UI Code များကို သပ်ရပ်စေရန် Custom Widget ထုတ်ထားခြင်း
  Widget _buildPitakaCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // သက်ဆိုင်ရာ Title အလိုက် Sub Category များ သတ်မှတ်ခြင်း
          List<String> subCategories = [];
          if (title == 'ဝိနည်းပိဋကတ်') {
            subCategories = [
              '၁။ ပါရာဇိက',
              '၂။ သံဃာဒိသိသ်',
              '၃။ အနိယတ',
              '၄။ နိဿဂ္ဂိယ',
              '၅။ ဝိနယပိဋက',
            ];
          } else if (title == 'သုတ္တန္တပိဋကတ်') {
            subCategories = [
              '၁။ ဒီဃနိကာယ',
              '၂။ မဇ္ဈိမနိကာယ',
              '၃။ သံယုတ္တနိကာယ',
              '၄။ အင်္ဂုတ္တရနိကာယ',
              '၅။ ခုဒ္ဒကနိကာယ',
            ];
          } else if (title == 'အဘိဓမ္မပိဋကတ်') {
            subCategories = [
              '၁။ ဓမ္မသင်္ဂဏီ',
              '၂။ ဝိဘင်္ဂ',
              '၃။ ဓာတုကထာ',
              '၄။ ကထာဝတ္ထု',
            ];
          }

          // PitakaDetailScreen သို့ ကူးပြောင်းခြင်း
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PitakaDetailScreen(
                title: title,
                subCategories: subCategories,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.brown),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
