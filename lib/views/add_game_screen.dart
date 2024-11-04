import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/game.dart';
 
class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key}); // Adicionado super.key ao construtor
 
  @override
  AddGameScreenState createState() => AddGameScreenState();
}
 
class AddGameScreenState extends State<AddGameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _genreController = TextEditingController();
  final _releaseYearController = TextEditingController();
  final GameController _gameController = GameController();
 
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _genreController.dispose();
    _releaseYearController.dispose();
    super.dispose();
  }
 
  void _addGame() async {
    if (_formKey.currentState!.validate()) {
      final newGame = Game(
        id: '', // ID será gerado pelo Firestore
        title: _titleController.text,
        description: _descriptionController.text,
        genre: _genreController.text,
        releaseYear: int.parse(_releaseYearController.text),
      );
 
      try {
        await _gameController.addGame(newGame);
        if (mounted) { // Verificando se o widget está montado
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Jogo adicionado com sucesso!')),
          );
          Navigator.pop(context);
        }
      } catch (error) {
        if (mounted) { // Verificando se o widget está montado
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao adicionar o jogo: $error')),
          );
        }
      }
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Jogo')),
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
                onPressed: _addGame,
                child: const Text('Salvar Jogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}