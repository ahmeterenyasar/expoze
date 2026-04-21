import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/profile_preferences_model.dart';
import '../../../data/models/reflection_entry_model.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/local_db_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required ILocalDbService dbService})
    : _dbService = dbService,
      super(const ProfileState());

  final ILocalDbService _dbService;
  String _activeUserId = 'local-user';

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));

    try {
      final UserModel? user = await _dbService.getUser();
      _activeUserId = user?.userId ?? 'local-user';

      final List<TaskModel> allTasks = await _dbService.getAllTasks();
      final ProfilePreferencesModel? prefs = await _dbService
          .getProfilePreferences(_activeUserId);
      final List<ReflectionEntryModel> reflectionRows = await _dbService
          .getReflectionEntries(_activeUserId);

      final List<ProfileFearItem> fearItems = _resolveFearItems(
        prefs: prefs,
        tasks: allTasks,
      );

      final List<ReflectionEntry> reflections = reflectionRows
          .map(
            (item) => ReflectionEntry(
              date: _formatDate(item.date),
              title: item.title,
              description: item.description,
              badgeText: 'Anxiety: ${item.anxietyBefore}→${item.anxietyAfter}',
              badgeColor: _badgeColor(item.anxietyBefore - item.anxietyAfter),
            ),
          )
          .toList();

      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          displayName: (user?.userId.isNotEmpty ?? false)
              ? user!.userId
              : 'Alex Rivera',
          courageLevel: user?.currentCourageLevel ?? 4,
          totalXp: user?.totalXP ?? 320,
          fearMap: fearItems,
          selectedRhythm: _rhythmFromString(prefs?.selectedRhythm),
          reflections: reflections,
          draftFearName: '',
          selectedIntensity: 3,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'Profile could not be loaded.',
        ),
      );
    }
  }

  void setDraftFearName(String value) {
    emit(state.copyWith(draftFearName: value));
  }

  void setSelectedIntensity(int intensity) {
    emit(state.copyWith(selectedIntensity: intensity.clamp(1, 5)));
  }

  void addDraftFear() {
    final String draft = state.draftFearName.trim();
    if (draft.isEmpty) {
      return;
    }

    final List<ProfileFearItem> updated = <ProfileFearItem>[
      ...state.fearMap,
      ProfileFearItem(
        title: draft,
        subtitle: 'Added from profile',
        intensity: state.selectedIntensity,
      ),
    ];

    emit(state.copyWith(fearMap: updated, draftFearName: ''));
    _persistPreferences();
  }

  void removeFearAt(int index) {
    if (index < 0 || index >= state.fearMap.length) {
      return;
    }

    final List<ProfileFearItem> updated = List<ProfileFearItem>.from(
      state.fearMap,
    )..removeAt(index);

    emit(state.copyWith(fearMap: updated));
    _persistPreferences();
  }

  void setRhythm(TherapyRhythm rhythm) {
    emit(state.copyWith(selectedRhythm: rhythm));
    _persistPreferences();
  }

  Future<void> _persistPreferences() async {
    final model = ProfilePreferencesModel(
      userId: _activeUserId,
      selectedRhythm: _rhythmToString(state.selectedRhythm),
      fearMap: state.fearMap
          .map(
            (item) => FearMapItemEmbedded(
              title: item.title,
              subtitle: item.subtitle,
              intensity: item.intensity,
            ),
          )
          .toList(),
      updatedAt: DateTime.now(),
    );

    await _dbService.saveProfilePreferences(model);
  }

  List<ProfileFearItem> _resolveFearItems({
    required ProfilePreferencesModel? prefs,
    required List<TaskModel> tasks,
  }) {
    if (prefs != null && prefs.fearMap.isNotEmpty) {
      return prefs.fearMap
          .map(
            (item) => ProfileFearItem(
              title: item.title,
              subtitle: item.subtitle,
              intensity: item.intensity.clamp(1, 5),
            ),
          )
          .toList();
    }

    final topTasks = tasks.where((t) => !t.isCompleted).take(3).toList();
    return topTasks
        .map(
          (task) => ProfileFearItem(
            title: task.title,
            subtitle: task.description,
            intensity: task.anxietyLevel.clamp(1, 5),
          ),
        )
        .toList();
  }

  TherapyRhythm _rhythmFromString(String? value) {
    switch (value) {
      case 'restWeek':
        return TherapyRhythm.restWeek;
      case 'pushMe':
        return TherapyRhythm.pushMe;
      case 'steady':
      default:
        return TherapyRhythm.steady;
    }
  }

  String _rhythmToString(TherapyRhythm rhythm) {
    switch (rhythm) {
      case TherapyRhythm.restWeek:
        return 'restWeek';
      case TherapyRhythm.pushMe:
        return 'pushMe';
      case TherapyRhythm.steady:
        return 'steady';
    }
  }

  Color _badgeColor(int delta) {
    if (delta >= 3) {
      return AppColors.sage700;
    }
    if (delta >= 1) {
      return AppColors.amber700;
    }
    return AppColors.lilac700;
  }

  String _formatDate(DateTime date) {
    const months = <String>[
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month]} ${date.day}, ${date.year}';
  }
}
