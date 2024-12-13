import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../utils/form_validators.dart';

class EditFlashcardScreen extends StatefulWidget {
  final Flashcard flashcard;
  final void Function(Flashcard) onEditFlashcard;

  const EditFlashcardScreen({
    super.key,
    required this.flashcard,
    required this.onEditFlashcard,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditFlashcardScreenState createState() => _EditFlashcardScreenState();
}

class _EditFlashcardScreenState extends State<EditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _question;
  late String _answer;

  @override
  void initState() {
    super.initState();
    _question = widget.flashcard.question;
    _answer = widget.flashcard.answer;
  }

  void _saveFlashcard() {
    if (_formKey.currentState!.validate()) {
      final updatedFlashcard = widget.flashcard.copyWith(
        question: _question,
        answer: _answer,
      );
      widget.onEditFlashcard(updatedFlashcard);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _question,
                decoration: const InputDecoration(hintText: 'Question'),
                validator: formFieldRequiredValidator,
                onChanged: (value) => _question = value,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: _answer,
                decoration: const InputDecoration(hintText: 'Answer'),
                validator: formFieldRequiredValidator,
                onChanged: (value) => _answer = value,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveFlashcard,
                child: const Text('Save Flashcard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
