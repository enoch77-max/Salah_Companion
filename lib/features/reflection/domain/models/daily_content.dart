enum DailyContentType {
  hadith,
  ayah;

  static DailyContentType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'hadith':
        return DailyContentType.hadith;
      case 'ayah':
        return DailyContentType.ayah;
      default:
        throw FormatException('Unknown daily content type: $type');
    }
  }

  String toJson() => name;
}

class DailyContentItem {
  final String id;
  final DailyContentType type;
  final String reference;
  final double sourceWeight;
  final String? grade;
  final String? gradedBy;
  final String arabicText;
  final String translationText;
  final String translationSource;
  final String? occasion;
  final List<String> tags;

  const DailyContentItem({
    required this.id,
    required this.type,
    required this.reference,
    required this.sourceWeight,
    this.grade,
    this.gradedBy,
    required this.arabicText,
    required this.translationText,
    required this.translationSource,
    this.occasion,
    this.tags = const [],
  });

  factory DailyContentItem.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String?;
    if (id == null || id.isEmpty) {
      throw const FormatException('DailyContentItem missing "id"');
    }

    final typeStr = json['type'] as String?;
    if (typeStr == null || typeStr.isEmpty) {
      throw FormatException('DailyContentItem $id missing "type"');
    }
    final type = DailyContentType.fromString(typeStr);

    final arabicText = json['arabic_text'] as String?;
    if (arabicText == null || arabicText.trim().isEmpty) {
      throw FormatException('DailyContentItem $id missing "arabic_text"');
    }

    final translationText = json['translation_text'] as String?;
    if (translationText == null || translationText.trim().isEmpty) {
      throw FormatException('DailyContentItem $id missing "translation_text"');
    }

    final translationSource = json['translation_source'] as String?;
    if (translationSource == null || translationSource.trim().isEmpty) {
      throw FormatException('DailyContentItem $id missing "translation_source"');
    }

    final reference = json['reference'] as String?;
    if (reference == null || reference.trim().isEmpty) {
      throw FormatException('DailyContentItem $id missing "reference"');
    }

    final sourceWeight = (json['source_weight'] as num?)?.toDouble() ?? 1.0;
    final grade = json['grade'] as String?;
    final gradedBy = json['graded_by'] as String?;
    final occasion = json['occasion'] as String?;
    final tagsList = (json['tags'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        const <String>[];

    if (type == DailyContentType.hadith) {
      if (grade != 'Sahih') {
        throw FormatException(
            'Hadith item $id must have grade "Sahih", got: $grade');
      }
      if (gradedBy == null || gradedBy.trim().isEmpty) {
        throw FormatException(
            'Hadith item $id must have a non-empty graded_by field');
      }
    }

    return DailyContentItem(
      id: id,
      type: type,
      reference: reference,
      sourceWeight: sourceWeight,
      grade: grade,
      gradedBy: gradedBy,
      arabicText: arabicText,
      translationText: translationText,
      translationSource: translationSource,
      occasion: occasion,
      tags: tagsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toJson(),
      'reference': reference,
      'source_weight': sourceWeight,
      if (grade != null) 'grade': grade,
      if (gradedBy != null) 'graded_by': gradedBy,
      'arabic_text': arabicText,
      'translation_text': translationText,
      'translation_source': translationSource,
      if (occasion != null) 'occasion': occasion,
      'tags': tags,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyContentItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
