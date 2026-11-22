import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tipitaka_myanmar/features/home/data/favorites_recent_provider.dart';
import 'package:tipitaka_myanmar/features/reader/presentation/pages/reader_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'အားလုံးဖျက်ရန်',
              onPressed: () {
                ref.read(favoritesProvider.notifier).clearAll();
              },
            ),
        ],
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('Favorites မှတ်ထားသည်များ မရှိသေးပါ။'))
          : ListView.separated(
              itemCount: favorites.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = favorites[index];
                return ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text(item.chapterTitle),
                  subtitle: Text('${item.pitakaTitle} > ${item.subTitle}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.grey),
                    onPressed: () {
                      ref.read(favoritesProvider.notifier).removeItem(item);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReaderScreen(
                          pitakaTitle: item.pitakaTitle,
                          subTitle: item.subTitle,
                          chapterTitle: item.chapterTitle,
                          fileName: item.fileName,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class RecentScreen extends ConsumerWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recents = ref.watch(recentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          if (recents.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'အားလုံးဖျက်ရန်',
              onPressed: () {
                ref.read(recentProvider.notifier).clearAll();
              },
            ),
        ],
      ),
      body: recents.isEmpty
          ? const Center(child: Text('မကြာသေးမီက ဖတ်ရှုထားသည်များ မရှိသေးပါ။'))
          : ListView.separated(
              itemCount: recents.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = recents[index];
                return ListTile(
                  leading: const Icon(Icons.history, color: Colors.brown),
                  title: Text('${item.pitakaTitle} > ${item.subTitle}'),
                  subtitle: Text(item.chapterTitle),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.grey),
                    onPressed: () {
                      ref.read(recentProvider.notifier).removeItem(item);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReaderScreen(
                          pitakaTitle: item.pitakaTitle,
                          subTitle: item.subTitle,
                          chapterTitle: item.chapterTitle,
                          fileName: item.fileName,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
