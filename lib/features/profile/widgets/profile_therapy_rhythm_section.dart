import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../cubit/profile_state.dart';
import 'therapy_rhythm_option_card.dart';

class ProfileTherapyRhythmSection extends StatelessWidget {
  const ProfileTherapyRhythmSection({
    super.key,
    required this.selectedRhythm,
    required this.onRhythmSelected,
  });

  final TherapyRhythm selectedRhythm;
  final ValueChanged<TherapyRhythm> onRhythmSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutral250),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MY THERAPY RHYTHM',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              letterSpacing: 1.1,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'How do you want to be pushed this week?',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onRhythmSelected(TherapyRhythm.restWeek),
                  child: TherapyRhythmOptionCard(
                    icon: Icons.nightlight_round,
                    title: 'Rest week',
                    subtitle: 'Light, easy tasks',
                    selected: selectedRhythm == TherapyRhythm.restWeek,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => onRhythmSelected(TherapyRhythm.steady),
                  child: TherapyRhythmOptionCard(
                    icon: Icons.show_chart_rounded,
                    title: 'Steady',
                    subtitle: 'My usual pace',
                    selected: selectedRhythm == TherapyRhythm.steady,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => onRhythmSelected(TherapyRhythm.pushMe),
                  child: TherapyRhythmOptionCard(
                    icon: Icons.bolt_rounded,
                    title: 'Push me',
                    subtitle: 'Challenge tasks',
                    selected: selectedRhythm == TherapyRhythm.pushMe,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundCream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Tasks matched to your fear map at your natural pace.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
