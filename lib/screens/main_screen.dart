import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../widgets/flashcard_widget.dart';
import 'add_flashcard_screen.dart';
import 'edit_flashcard_screen.dart';
import '../widgets/confirmation_dialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Flashcard> _flashcards = [];

  void _addFlashcard(Flashcard flashcard) {
    setState(() {
      _flashcards.add(flashcard);
    });
  }

  void _editFlashcard(int index, Flashcard updatedFlashcard) {
    setState(() {
      _flashcards[index] = updatedFlashcard;
    });
  }

  void _deleteFlashcard(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmationDialog(
        title: 'Delete Flashcard',
        content: 'Are you sure you want to delete this flashcard?',
      ),
    );

    if (confirmed == true) {
      setState(() {
        _flashcards.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard App'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: _flashcards.length,
        itemBuilder: (context, index) {
          final flashcard = _flashcards[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: FlashcardWidget(
              flashcard: flashcard,
              onEdit: () => _navigateToEditScreen(index, flashcard),
              onDelete: () => _deleteFlashcard(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddScreen,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _navigateToAddScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFlashcardScreen(onAddFlashcard: _addFlashcard),
      ),
    );
  }

  void _navigateToEditScreen(int index, Flashcard flashcard) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFlashcardScreen(
          flashcard: flashcard,
          onEditFlashcard: (updatedFlashcard) =>
              _editFlashcard(index, updatedFlashcard),
        ),
      ),
    );
  }
}
