import 'package:flutter/material.dart';

class PitakaDetailScreen extends StatelessWidget {
  final String title;
  final List<String> subCategories;

  const PitakaDetailScreen({
    Key? key,
    required this.title,
    required this.subCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12.0),
        itemCount: subCategories.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final subTitle = subCategories[index];

          return ListTile(
            leading: const Icon(Icons.bookmark, color: Colors.brown),
            title: Text(
              subTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {
              // PDF Data ကို အခြေခံပြီး တတိယအဆင့် Sub-title များကို ဥပမာအနေဖြင့် သတ်မှတ်ခြင်း
              List<String> chapters = [];
              if (subTitle.contains('ပါရာဇိက')) {
                chapters = [
                  'ပထမသိက္ခာပုဒ်',
                  'ဒုတိယသိက္ခာပုဒ်',
                  'တတိယသိက္ခာပုဒ်',
                  'စတုတ္ထသိက္ခာပုဒ်',
                ]; //
              } else if (subTitle.contains('သံဃာဒိသိသ်')) {
                chapters = ['ပထမသံဃာဒိသိသ်', 'ဒုတိယသံဃာဒိသိသ်'];
              }

              if (chapters.isNotEmpty) {
                // တတိယအဆင့် Sub-titles များရှိပါက Chapter List ဆီသို့ သွားရန်
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PitakaDetailScreen(
                      title: subTitle,
                      subCategories: chapters,
                    ),
                  ),
                );
              } else {
                // Chapter ထပ်မရှိတော့ပါက စာဖတ်ရန် (Reader Screen) ဆီသို့ တိုက်ရိုက်သွားရန်
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$subTitle ဖတ်ရန် စာမျက်နှာသို့ သွားမည်'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
