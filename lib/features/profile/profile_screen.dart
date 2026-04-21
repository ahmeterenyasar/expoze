import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/theme.dart';
import '../../core/widgets/custom_bottom_nav_bar.dart';
import '../../data/services/local_db_service.dart';
import '../tasks/tasks_screen.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/profile_state.dart';
import 'widgets/profile_fear_map_section.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_reflection_archive_section.dart';
import 'widgets/profile_therapy_rhythm_section.dart';
import 'widgets/profile_user_summary.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.dbService,
  });

  final ILocalDbService dbService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => ProfileCubit(dbService: dbService)..load(),
      child: _ProfileView(dbService: dbService),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView({required this.dbService});

  final ILocalDbService dbService;

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  late final TextEditingController _fearNameController;

  @override
  void initState() {
    super.initState();
    _fearNameController = TextEditingController();
  }

  @override
  void dispose() {
    _fearNameController.dispose();
    super.dispose();
  }

  void _onNavItemSelected(BuildContext context, int index) {
    if (index == 2) {
      return;
    }

    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => TasksScreen(dbService: widget.dbService),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This section will be available soon.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (BuildContext context, ProfileState state) {
            final String? message = state.errorMessage;
            if (state.status == ProfileStatus.error && message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            }
          },
          builder: (BuildContext context, ProfileState state) {
            if (state.status == ProfileStatus.loading ||
                state.status == ProfileStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_fearNameController.text != state.draftFearName) {
              _fearNameController.value = TextEditingValue(
                text: state.draftFearName,
                selection: TextSelection.collapsed(
                  offset: state.draftFearName.length,
                ),
              );
            }

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(overscroll: false),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const ProfileHeader(),
                      const SizedBox(height: 14),
                      ProfileUserSummary(
                        displayName: state.displayName,
                        courageLevel: state.courageLevel,
                        totalXp: state.totalXp,
                      ),
                      const SizedBox(height: 16),
                      ProfileFearMapSection(
                        items: state.fearMap,
                        selectedIntensity: state.selectedIntensity,
                        fearNameController: _fearNameController,
                        onDraftChanged: context
                            .read<ProfileCubit>()
                            .setDraftFearName,
                        onIntensitySelected: context
                            .read<ProfileCubit>()
                            .setSelectedIntensity,
                        onAddPressed: context.read<ProfileCubit>().addDraftFear,
                        onRemove: context.read<ProfileCubit>().removeFearAt,
                      ),
                      const SizedBox(height: 14),
                      ProfileTherapyRhythmSection(
                        selectedRhythm: state.selectedRhythm,
                        onRhythmSelected: context
                            .read<ProfileCubit>()
                            .setRhythm,
                      ),
                      const SizedBox(height: 14),
                      ProfileReflectionArchiveSection(
                        entries: state.reflections,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onItemSelected: (int index) => _onNavItemSelected(context, index),
        items: const <CustomBottomNavBarItem>[
          CustomBottomNavBarItem(
            label: 'Tasks',
            icon: Icon(Icons.task_alt_rounded),
          ),
          CustomBottomNavBarItem(
            label: 'Progress',
            icon: Icon(Icons.bar_chart_rounded),
          ),
          CustomBottomNavBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_outline_rounded),
          ),
        ],
      ),
    );
  }
}
