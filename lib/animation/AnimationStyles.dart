import 'package:flutter/material.dart';

class AnimationStyles {
  static Animation<double> getAnimationForTheme(ThemeData theme, AnimationController controller) {
    if (theme.colorScheme.primary == Colors.blue) {
      // Theme 1 animations
      return CurvedAnimation(parent: controller, curve: Curves.easeIn);
    } else if (theme.colorScheme.primary == Colors.green) {
      // Theme 2 animations
      return CurvedAnimation(parent: controller, curve: Curves.slowMiddle);
    } else if (theme.colorScheme.primary == Colors.yellow) {
      // Theme 2 animations
      return CurvedAnimation(parent: controller, curve: Curves.decelerate);
    } else if (theme.colorScheme.primary == Colors.pink) {
      // Theme 2 animations
      return CurvedAnimation(parent: controller, curve: Curves.fastEaseInToSlowEaseOut);
    } else {
      // Default animations
      return CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    }
  }

  static Widget getAnimatedWidgetForTheme(
      ThemeData theme,
      Widget child,
      AnimationController controller,
      ) {
    if (theme.colorScheme.primary == Colors.blue) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: controller, curve: Curves.easeIn),
        child: child,
      );
    } else if (theme.colorScheme.primary == Colors.green) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: controller, curve: Curves.easeOut),
        child: child,
      );
    }else if (theme.colorScheme.primary == Colors.orange) {
      // Rotation Animation
      return RotationTransition(
        turns: CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        child: child,
      );
    }
    else if (theme.colorScheme.primary == Colors.pink) {
      // Rotation Animation
      return SizeTransition(
        sizeFactor: CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        child: child,
      );
    } else if (theme.colorScheme.primary == Colors.black) {
      // Rotation Animation
      return RotationTransition(
        turns: CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        child: child,
      );
    } else {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: controller, curve: Curves.linear)),
        child: child,
      );
    }
  }
}
