import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../utils/form_validators.dart';

class AddFlashcardScreen extends StatefulWidget {
  final void Function(Flashcard) onAddFlashcard;

  const AddFlashcardScreen({super.key, required this.onAddFlashcard});

  @override
  // ignore: library_private_types_in_public_api
  _AddFlashcardScreenState createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  String _question = '';
  String _answer = '';

  void _saveFlashcard() {
    if (_formKey.currentState!.validate()) {
      final newFlashcard = Flashcard(question: _question, answer: _answer);
      widget.onAddFlashcard(newFlashcard);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Question'),
                validator: formFieldRequiredValidator,
                onChanged: (value) => _question = value,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
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
