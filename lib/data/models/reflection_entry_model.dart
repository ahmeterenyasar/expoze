import 'package:isar/isar.dart';

part 'reflection_entry_model.g.dart';

@collection
class ReflectionEntryModel {
  ReflectionEntryModel({
    this.id = Isar.autoIncrement,
    required this.userId,
    required this.date,
    required this.title,
    required this.description,
    required this.anxietyBefore,
    required this.anxietyAfter,
  });

  Id id;
  @Index()
  late String userId;
  late DateTime date;
  late String title;
  late String description;
  late int anxietyBefore;
  late int anxietyAfter;
}
