import 'package:flutter/material.dart';

final double _width = 400;
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
                fontWeight: FontWeight.bold,
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
    final buttonColor = theme.colorScheme.tertiary;
    final buttonTextColor = theme.colorScheme.onTertiary;
    final borderColor = theme.colorScheme.tertiary;

    return Material(
      elevation: 10.0,
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
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ActionPrimaryButton extends StatelessWidget {
  final String buttonText;
  final double buttonTextSize;

  const ActionPrimaryButton({
    super.key,
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
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ActionSecondaryButton extends StatelessWidget {
  final String buttonText;
  final double buttonTextSize;

  const ActionSecondaryButton({
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

    return Material(
      elevation: 10.0,
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
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
