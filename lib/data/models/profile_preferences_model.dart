import 'package:isar/isar.dart';

part 'profile_preferences_model.g.dart';

@embedded
class FearMapItemEmbedded {
  FearMapItemEmbedded({
    this.title = '',
    this.subtitle = '',
    this.intensity = 1,
  });

  late String title;
  late String subtitle;
  late int intensity;
}

@collection
class ProfilePreferencesModel {
  ProfilePreferencesModel({
    this.id = Isar.autoIncrement,
    required this.userId,
    required this.selectedRhythm,
    this.fearMap = const <FearMapItemEmbedded>[],
    required this.updatedAt,
  });

  Id id;

  @Index(unique: true, replace: true)
  late String userId;

  late String selectedRhythm;
  List<FearMapItemEmbedded> fearMap;
  late DateTime updatedAt;
}
