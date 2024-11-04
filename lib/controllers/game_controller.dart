import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/game.dart';
 
class GameController {
  final CollectionReference gamesCollection = FirebaseFirestore.instance.collection('games');
 
  Future<void> addGame(Game game) async {
    await gamesCollection.add(game.toMap());
  }
 
  Stream<List<Game>> getGames() {
    return gamesCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Game.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }
 
  Future<void> updateGame(Game game) async {
    await gamesCollection.doc(game.id).update(game.toMap());
  }
 
  Future<void> deleteGame(String id) async {
    await gamesCollection.doc(id).delete();
  }
}