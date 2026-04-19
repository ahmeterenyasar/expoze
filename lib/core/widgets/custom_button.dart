import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: ShapeDecoration(
            color: AppColors.sage400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 66.77,
                child: Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.buttonLabel,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
