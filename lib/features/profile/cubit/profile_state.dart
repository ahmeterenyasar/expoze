import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ProfileStatus { initial, loading, loaded, error }

enum TherapyRhythm { restWeek, steady, pushMe }

class ProfileFearItem extends Equatable {
  const ProfileFearItem({
    required this.title,
    required this.subtitle,
    required this.intensity,
  });

  final String title;
  final String subtitle;
  final int intensity;

  @override
  List<Object?> get props => <Object?>[title, subtitle, intensity];
}

class ReflectionEntry extends Equatable {
  const ReflectionEntry({
    required this.date,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.badgeColor,
  });

  final String date;
  final String title;
  final String description;
  final String badgeText;
  final Color badgeColor;

  @override
  List<Object?> get props => <Object?>[
    date,
    title,
    description,
    badgeText,
    badgeColor,
  ];
}

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.displayName = 'Alex Rivera',
    this.courageLevel = 4,
    this.totalXp = 320,
    this.fearMap = const <ProfileFearItem>[],
    this.selectedIntensity = 3,
    this.draftFearName = '',
    this.selectedRhythm = TherapyRhythm.steady,
    this.reflections = const <ReflectionEntry>[],
    this.errorMessage,
  });

  final ProfileStatus status;
  final String displayName;
  final int courageLevel;
  final int totalXp;
  final List<ProfileFearItem> fearMap;
  final int selectedIntensity;
  final String draftFearName;
  final TherapyRhythm selectedRhythm;
  final List<ReflectionEntry> reflections;
  final String? errorMessage;

  ProfileState copyWith({
    ProfileStatus? status,
    String? displayName,
    int? courageLevel,
    int? totalXp,
    List<ProfileFearItem>? fearMap,
    int? selectedIntensity,
    String? draftFearName,
    TherapyRhythm? selectedRhythm,
    List<ReflectionEntry>? reflections,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      displayName: displayName ?? this.displayName,
      courageLevel: courageLevel ?? this.courageLevel,
      totalXp: totalXp ?? this.totalXp,
      fearMap: fearMap ?? this.fearMap,
      selectedIntensity: selectedIntensity ?? this.selectedIntensity,
      draftFearName: draftFearName ?? this.draftFearName,
      selectedRhythm: selectedRhythm ?? this.selectedRhythm,
      reflections: reflections ?? this.reflections,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    displayName,
    courageLevel,
    totalXp,
    fearMap,
    selectedIntensity,
    draftFearName,
    selectedRhythm,
    reflections,
    errorMessage,
  ];
}
