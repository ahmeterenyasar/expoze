import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class SwipeCompleteAction extends StatefulWidget {
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
  State<SwipeCompleteAction> createState() => _SwipeCompleteActionState();
}

class _SwipeCompleteActionState extends State<SwipeCompleteAction> {
  static const double _thumbSize = 50;
  static const double _trackPadding = 4;
  static const double _trackHeight = 58;

  double _thumbLeft = _trackPadding;
  bool _isCompleted = false;

  @override
  void didUpdateWidget(covariant SwipeCompleteAction oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resetSignal != widget.resetSignal) {
      _reset();
    }
  }

  void _reset() {
    if (!mounted) {
      return;
    }

    setState(() {
      _isCompleted = false;
      _thumbLeft = _trackPadding;
    });
  }

  void _onDragUpdate(DragUpdateDetails details, double maxLeft) {
    if (!widget.enabled || _isCompleted) {
      return;
    }

    setState(() {
      _thumbLeft = (_thumbLeft + details.delta.dx).clamp(_trackPadding, maxLeft);
    });
  }

  void _onDragEnd(double maxLeft) {
    if (!widget.enabled || _isCompleted) {
      return;
    }

    final progress = ((_thumbLeft - _trackPadding) / (maxLeft - _trackPadding)).clamp(0.0, 1.0);
    if (progress >= 0.92) {
      setState(() {
        _isCompleted = true;
        _thumbLeft = maxLeft;
      });
      widget.onCompleted();
      return;
    }

    setState(() {
      _thumbLeft = _trackPadding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxLeft = constraints.maxWidth - (_thumbSize + _trackPadding);
        final fillWidth = (_thumbLeft + _thumbSize).clamp(_thumbSize + _trackPadding, constraints.maxWidth);
        final progress = ((_thumbLeft - _trackPadding) / (maxLeft - _trackPadding)).clamp(0.0, 1.0);

        return SizedBox(
          height: _trackHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.sage200,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 80),
                curve: Curves.linear,
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: fillWidth,
                  decoration: BoxDecoration(
                    color: AppColors.sage600,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: 1 - progress,
                  child: Text(
                    widget.label,
                    style: AppTextStyles.taskTitle.copyWith(
                      color: AppColors.sage800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 80),
                curve: Curves.linear,
                left: _thumbLeft,
                top: _trackPadding,
                child: GestureDetector(
                  onHorizontalDragUpdate: widget.enabled ? (details) => _onDragUpdate(details, maxLeft) : null,
                  onHorizontalDragEnd: widget.enabled ? (_) => _onDragEnd(maxLeft) : null,
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
