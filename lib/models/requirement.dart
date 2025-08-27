class Requirement {
  final String text;
  bool isChecked;

  Requirement({required this.text, required this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isChecked': isChecked,
    };
  }

  factory Requirement.fromMap(Map<String, dynamic> map) {
    return Requirement(
      text: map['text'] ?? '',
      isChecked: map['isChecked'] ?? false,
    );
  }
}