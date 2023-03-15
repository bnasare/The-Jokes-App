class Jokes {
  num id;
  String type;
  String setup;
  String punchline;

  Jokes({
  required this.id,
  required this.type,
  required this.punchline,
  required this.setup});

  factory Jokes.fromJson(Map<String, dynamic> jokes){
    return Jokes(
    id: jokes['id'],
    type: jokes['type'],
    punchline: jokes['punchline'],
    setup: jokes['setup']);
  }
}