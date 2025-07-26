class CommitActivity {
  final DateTime date;
  final int commitCount;

  CommitActivity({
    required this.date,
    required this.commitCount,
  });

  CommitActivity copyWith({
    DateTime? date,
    int? commitCount,
  }) {
    return CommitActivity(
      date: date ?? this.date,
      commitCount: commitCount ?? this.commitCount,
    );
  }
}
