import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/game.dart';
import 'add_game_screen.dart';
import 'edit_game_screen.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key); // Usando o parâmetro key corretamente
 
  @override
  HomeScreenState createState() => HomeScreenState();
}
 
class HomeScreenState extends State<HomeScreen> {
  final GameController _gameController = GameController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Jogos')), // Usando const
      body: StreamBuilder<List<Game>>(
        stream: _gameController.getGames(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar jogos.')); // Mensagem de erro não constante
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Usando const
          }
          final games = snapshot.data ?? [];
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return ListTile(
                title: Text(game.title),
                subtitle: Text(game.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit), // Usando const
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditGameScreen(game: game),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete), // Usando const
                      onPressed: () => _gameController.deleteGame(game.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddGameScreen()), // Usando const
        ),
        child: const Icon(Icons.add), // Usando const
      ),
    );
  }
}