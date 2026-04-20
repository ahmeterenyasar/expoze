import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../core/theme/theme.dart';

class SwipeCompleteAction extends StatelessWidget {
  const SwipeCompleteAction({
    super.key,
    required this.onCompleted,
    this.label = 'Swipe to complete',
    this.resetSignal = 0,
    this.enabled = true,
  });

  final VoidCallback onCompleted;
  final String label;
  final int resetSignal;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.7,
        child: SizedBox(
          height: 58,
          child: SlideAction(
            key: ValueKey<int>(resetSignal),
            text: label,
            textStyle: AppTextStyles.taskTitle.copyWith(
              color: AppColors.sage800,
              fontWeight: FontWeight.w600,
            ),
            outerColor: AppColors.sage200,
            innerColor: AppColors.surface,
            borderRadius: 100,
            elevation: 0,
            sliderButtonIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.primary,
            ),
            onSubmit: () async {
              onCompleted();
              return;
            },
          ),
        ),
      ),
    );
  }
}
