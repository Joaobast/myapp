class Game {
  final String id;
  final String title;
  final String description;
  final String genre;
  final int releaseYear;
 
  Game({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.releaseYear,
  });
 
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'genre': genre,
      'releaseYear': releaseYear,
    };
  }
 
  factory Game.fromMap(String id, Map<String, dynamic> map) {
    return Game(
      id: id,
      title: map['title'],
      description: map['description'],
      genre: map['genre'],
      releaseYear: map['releaseYear'],
    );
  }
}