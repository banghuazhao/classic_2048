import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class GameActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const GameActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<GameActionButton> createState() => _GameActionButtonState();
}

class _GameActionButtonState extends State<GameActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scale = Tween(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: child,
      ),
      child: Semantics(
        button: true,
        label: widget.label,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            HapticFeedback.lightImpact();
            widget.onPressed();
          },
          onTapCancel: () => _controller.reverse(),
          child: Padding(
            padding: AppInsets.button5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: AppColors.accent),
                const SizedBox(height: 4),
                Text(widget.label, style: AppTextStyles.actionButton),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scale = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: child,
      ),
      child: Semantics(
        button: true,
        label: widget.text,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            HapticFeedback.mediumImpact();
            widget.onPressed();
          },
          onTapCancel: () => _controller.reverse(),
          child: child,
        ),
      ),
    );
  }

  Widget get child => Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 28, left: 40, right: 40),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: AppRadii.levelButton,
          ),
          child: Center(
            child: Text(widget.text, style: AppTextStyles.levelButton),
          ),
        ),
      );
}

class PauseButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const PauseButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<PauseButton> createState() => _PauseButtonState();
}

class _PauseButtonState extends State<PauseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scale = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: child,
      ),
      child: Semantics(
        button: true,
        label: widget.text,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            HapticFeedback.lightImpact();
            widget.onPressed();
          },
          onTapCancel: () => _controller.reverse(),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: AppRadii.pauseButton,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            child: Text(widget.text, style: AppTextStyles.pauseButton),
          ),
        ),
      ),
    );
  }
}
