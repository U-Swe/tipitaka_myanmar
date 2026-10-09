class PitakaCategory {
  final String title;
  final List<PitakaSubCategory> subCategories;

  PitakaCategory({required this.title, required this.subCategories});
}

class PitakaSubCategory {
  final String title;
  final List<String>?
  chapters; // တတိယအဆင့် Sub-titles များအတွက် (ရွေးချယ်နိုင်ရန်)

  PitakaSubCategory({required this.title, this.chapters});
}
