import 'dart:convert';

class Items {
  final String counterKey;
  final int amount;
  final String transcription;
  final String translation;
  final bool isUserAdded;

  Items({
    required this.counterKey,
    required this.amount,
    required this.transcription,
    required this.translation,
    this.isUserAdded = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'counterKey': counterKey,
      'amount': amount,
      'transcription': transcription,
      'translation': translation,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      counterKey: map['counterKey'] as String,
      amount: map['amount'] as int, 
      transcription: map ['transcription'] as String, 
      translation: map ['translation'] as String
      );
  }

  String toJson() => jsonEncode(toMap());

  factory Items.fromJson(String source) => 
  Items.fromMap(jsonDecode(source));

}
