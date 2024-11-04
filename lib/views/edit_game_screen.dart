import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/game.dart'; // Certifique-se de que Game está público
 
class EditGameScreen extends StatefulWidget {
  final Game game;
 
  // O parâmetro key agora é um super parâmetro
  const EditGameScreen({super.key, required this.game});
 
  @override
  _EditGameScreenState createState() => _EditGameScreenState();
}
 
class _EditGameScreenState extends State<EditGameScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _genreController;
  late TextEditingController _releaseYearController;
  final GameController _gameController = GameController();
 
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.game.title);
    _descriptionController = TextEditingController(text: widget.game.description);
    _genreController = TextEditingController(text: widget.game.genre);
    _releaseYearController = TextEditingController(text: widget.game.releaseYear.toString());
  }
 
  void _updateGame() async {
    if (_formKey.currentState!.validate()) {
      final updatedGame = Game(
        id: widget.game.id,
        title: _titleController.text,
        description: _descriptionController.text,
        genre: _genreController.text,
        releaseYear: int.parse(_releaseYearController.text),
      );
 
      try {
        await _gameController.updateGame(updatedGame);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Jogo atualizado com sucesso!')),
          );
          Navigator.pop(context);
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao atualizar o jogo: $error')),
          );
        }
      }
    }
  }
 
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _genreController.dispose();
    _releaseYearController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Jogo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Por favor, insira o título'
                      : null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Por favor, insira a descrição'
                      : null;
                },
              ),
              TextFormField(
                controller: _genreController,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Por favor, insira o gênero'
                      : null;
                },
              ),
              TextFormField(
                controller: _releaseYearController,
                decoration: const InputDecoration(labelText: 'Ano de Lançamento'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Por favor, insira o ano de lançamento'
                      : null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateGame,
                child: const Text('Atualizar Jogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}