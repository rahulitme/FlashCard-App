class Flashcard {
  final String question;
  final String answer;

  Flashcard({
    required this.question,
    required this.answer,
  });

  Flashcard copyWith({
    String? question,
    String? answer,
  }) {
    return Flashcard(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }
}