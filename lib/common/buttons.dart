import 'package:flutter/material.dart';

final double _width = 300;
final double _height = 50;
final double _borderWidth = 2.0;
final BorderRadius _borderRadius = BorderRadius.circular(8);

class NavigationPrimaryButton extends StatelessWidget {
  final String route;
  final String buttonText;
  final double buttonTextSize;

  const NavigationPrimaryButton({
    super.key,
    required this.route,
    required this.buttonText,
    required this.buttonTextSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = theme.colorScheme.primary;
    final buttonTextColor = theme.colorScheme.onPrimary;
    final borderColor = theme.colorScheme.primary;

    return Material(
      elevation: 10.0,
      borderRadius: _borderRadius,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: _borderRadius,
            border: Border.all(
              color: borderColor,
              width: _borderWidth,
            ),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: buttonTextSize,
                color: buttonTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationSecondaryButton extends StatelessWidget {
  final String route;
  final String buttonText;
  final double buttonTextSize;

  const NavigationSecondaryButton({
    super.key,
    required this.route,
    required this.buttonText,
    required this.buttonTextSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = theme.colorScheme.secondary;
    final buttonTextColor = theme.colorScheme.onSecondary;
    final borderColor = theme.colorScheme.secondary;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: _borderRadius,
          border: Border.all(
            color: borderColor,
            width: _borderWidth,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: buttonTextSize,
              color: buttonTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String buttonText;
  final double buttonTextSize;

  const ActionButton({
    super.key,
    required this.buttonText,
    required this.buttonTextSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = theme.colorScheme.tertiary;
    final buttonTextColor = theme.colorScheme.onTertiary;
    final borderColor = theme.colorScheme.tertiary;

    return InkWell(
      onTap: () {},
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: _borderRadius,
          border: Border.all(
            color: borderColor,
            width: _borderWidth,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: buttonTextSize,
              color: buttonTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
