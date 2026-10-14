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

class PitakaModel {
  final String pitakaTitle;
  final List<SubCategory> subCategories;

  PitakaModel({required this.pitakaTitle, required this.subCategories});

  factory PitakaModel.fromJson(Map<String, dynamic> json) {
    return PitakaModel(
      pitakaTitle: json['pitakaTitle'],
      subCategories: (json['subCategories'] as List)
          .map((sub) => SubCategory.fromJson(sub))
          .toList(),
    );
  }
}

class SubCategory {
  final String subTitle;
  final List<Chapter> chapters;

  SubCategory({required this.subTitle, required this.chapters});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      subTitle: json['subTitle'],
      chapters: (json['chapters'] as List)
          .map((chap) => Chapter.fromJson(chap))
          .toList(),
    );
  }
}

class Chapter {
  final String chapterTitle;
  final String content;

  Chapter({required this.chapterTitle, required this.content});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterTitle: json['chapterTitle'],
      content: json['content'],
    );
  }
}
