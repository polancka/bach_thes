class User {
  final String username;
  final String profilePicture;
  final int id;
  final String email;
  final int level;
  final int points;
  final int bookletId;
  final bool scoreboardParticipation;
  User(
      {required this.username,
      required this.profilePicture,
      required this.id,
      required this.email,
      required this.level,
      required this.points,
      required this.bookletId,
      required this.scoreboardParticipation});
}
