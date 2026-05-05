class TaskTemplate {
  const TaskTemplate({
    required this.id,
    required this.focusAreaId,
    required this.title,
    required this.description,
    required this.minAnxiety,
    required this.maxAnxiety,
  });

  final String id;
  final String focusAreaId;
  final String title;
  final String description;
  final int minAnxiety;
  final int maxAnxiety;

  bool matchesAnxiety(int level) => level >= minAnxiety && level <= maxAnxiety;
}
