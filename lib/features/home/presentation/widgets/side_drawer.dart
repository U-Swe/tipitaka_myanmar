import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tipitaka_myanmar/features/home/presentation/pages/favorites_recent_screen.dart';
import 'package:tipitaka_myanmar/features/settings/presentation/pages/settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  // ဤနေရာတွင် သင်၏ Ebook Download Link နှင့် Email Address ကို ပြောင်းထည့်ပါ
  static const String ebookDownloadUrl =
      'https://drive.google.com/drive/folders/1UjJew45jYeOskKtG8xwd0JhBWHKbYLle?usp=drive_link';
  static const String contactEmail = 'kothanswe@gmail.com';

  Future<void> _launchURL(BuildContext context, String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not launch URL')));
      }
    }
  }

  void _showAcknowledgeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.volunteer_activism, color: Colors.brown),
            SizedBox(width: 8),
            Text('Acknowledgement'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ' ဤ app တွင် ပါဝင်သော အချက်အလက်များကို မှီငြမ်းကိုးကား ကူးယူခွင့်ပြုသော အောက်ပါ Website များနှင့် အဖွဲ့အစည်းများအား အထူးပင်ကျေးဇူးတင်ရှိပါသည် -',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),

              // ကိုးကားသော အဖွဲ့အစည်း / Website (၁)
              const Text(
                '• တိပိဋက မြန်မာပြန် E-book Download Website ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              InkWell(
                onTap: () => _launchURL(
                  context,
                  'https://www.dhammadownload.com/MyanmarTipitaka-eBook.htm',
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 12, top: 2, bottom: 10),
                  child: Text(
                    'https://www.dhammadownload.com/MyanmarTipitaka-eBook.htm',
                    style: TextStyle(
                      color: Colors.brown,
                      decoration: TextDecoration.underline,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              // ကိုးကားသော အဖွဲ့အစည်း / Website (၂)
              const Text(
                '• ကိုးကား',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              InkWell(
                onTap: () => _launchURL(context, 'https://tipitakapali.org/'),
                child: const Padding(
                  padding: EdgeInsets.only(left: 12, top: 2, bottom: 10),
                  child: Text(
                    'https://tipitakapali.org/',
                    style: TextStyle(
                      color: Colors.brown,
                      decoration: TextDecoration.underline,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                '\n** Personal Computer (PC) များအတွက် ခေါင်းစဥ်အလိုက် (Bookmark) ပြုလုပ်ထားသော PDF (eBook) ဖိုင်ကို Download လုပ်၍ ဖတ်ရှုနိုင်ပါသည်။   \n** ဤ app ကို Offline အသုံးပြုနိုင်ရန်အတွက် ဆောင်ရွက်ထားပါသည်။ \n** တစ်စုံတစ်ခု မှားယွင်းမှုများနှင့် လိုအပ်ချက်များရှိပါက မိမိတစ်ဥှီးတစ်ယောက်၏ တာဝန်သာ ဖြစ်ပါကြောင်း နှင့် ဝေဖန် အကြံပြုလိုပါက ဖော်ပြပါ Contact Us email သို့ ဆက်သွယ်နိုင်ပါသည်။ \n** ပါဝင်ကူညီပေးကြသော ဓမ္မမိတ်ဆွေများအားလုံးကိုလည်း ကျေးဇူးတင်ရှိပါသည်။',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Us'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Feedback and Inquirys: Email Address'),
            const SizedBox(height: 8),
            SelectableText(
              contactEmail,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(const ClipboardData(text: contactEmail));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Email address copied to clipboard'),
                ),
              );
            },
            child: const Text('Copy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _launchURL(
                context,
                'mailto:$contactEmail?subject=Tipitaka Myanmar App',
              );
            },
            child: const Text('Send Email'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.brown),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Tipitaka Myanmar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'ပိဋကတ် ၃ ပုံ မြန်မာပြန်',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            subtitle: const Text('Favorites Notes'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Recent'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RecentScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Download'),
            subtitle: const Text(
              'Tipitaka_Myanmar Ebook (PDF File) Download Link',
            ),
            onTap: () {
              Navigator.pop(context);
              _launchURL(context, ebookDownloadUrl);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            subtitle: const Text('Theme, Font Size'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.volunteer_activism_outlined),
            title: const Text('Acknowledgement'),
            subtitle: const Text('References & Credits'),
            onTap: () {
              Navigator.pop(context);
              _showAcknowledgeDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.pop(context);
              _showContactDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
