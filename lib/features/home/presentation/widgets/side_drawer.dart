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
        ).showSnackBar(const SnackBar(content: Text('လင့်ခ်ကို ဖွင့်၍မရပါ။')));
      }
    }
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
            const Text('ဆက်သွယ်ရန် အီးမေးလ်လိပ်စာ -'),
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
                  content: Text('အီးမေးလ်လိပ်စာကို Copy ကူးပြီးပါပြီ'),
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
            child: const Text('Email ပို့ရန်'),
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
            subtitle: const Text('Tipitaka_Myanmar Ebook Download Link'),
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
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () {
              Navigator.pop(context);
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
