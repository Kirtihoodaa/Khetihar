import 'package:flutter/material.dart';
import 'package:khetihar/Theme/AppColors.dart';

import '../Theme/FontSize.dart';

enum ButtonVariant { filled, outline, text }

enum IconPosition { start, end }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final ButtonVariant variant;
  final bool uppercase;
  final bool isLoading;
  final bool expand;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final double? elevation;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderWidth;

  final double? fontSize;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  final IconData? icon;
  final Widget? iconWidget;
  final double iconSize;
  final double iconGap;
  final IconPosition iconPosition;

  final bool autofocus;
  final FocusNode? focusNode;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.filled,
    this.uppercase = false,
    this.isLoading = false,
    this.expand = false,
    this.width,
    this.height,
    this.padding,
    this.radius,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.fontSize,
    this.fontWeight,
    this.textStyle,
    this.icon,
    this.iconWidget,
    this.iconSize = 18,
    this.iconGap = 8,
    this.iconPosition = IconPosition.start,
    this.autofocus = false,
    this.focusNode,
  });

  bool get _enabled => onPressed != null && !isLoading;

  ButtonStyle _buildStyle(BuildContext context) {
    final theme = Theme.of(context);
    final baseRadius = radius ?? 30.0;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(baseRadius),
    );

    final resolvedFg =
        foregroundColor ??
        (variant == ButtonVariant.filled
            ? Colors.white
            : theme.colorScheme.primary);

    final resolvedBg =
        backgroundColor ??
        (variant == ButtonVariant.filled
            ? AppColors.green
            : Colors.transparent);

    final resolvedBorder = borderColor ?? resolvedFg;

    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size(width ?? 0, height ?? 44)),
      padding: MaterialStateProperty.all(
        padding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      shape: MaterialStateProperty.all(shape),
      elevation: MaterialStateProperty.all(
        variant == ButtonVariant.filled ? (elevation ?? 0) : 0,
      ),
      backgroundColor: MaterialStateProperty.all(
        variant == ButtonVariant.filled ? resolvedBg : Colors.transparent,
      ),
      foregroundColor: MaterialStateProperty.all(resolvedFg),
      side:
          variant == ButtonVariant.outline
              ? MaterialStateProperty.all(
                BorderSide(color: resolvedBorder, width: borderWidth),
              )
              : null,
    );
  }

  Widget _buildChild(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveStyle =
        textStyle ??
        theme.textTheme.labelLarge?.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: foregroundColor,
        );

    final displayedText = uppercase ? text.toUpperCase() : text;

    final iconW =
        iconWidget ??
        (icon != null
            ? Icon(icon, size: iconSize, color: foregroundColor)
            : null);

    final label = Text(
      displayedText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: effectiveStyle,
    );

    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              valueColor: AlwaysStoppedAnimation<Color>(
                foregroundColor ??
                    (variant == ButtonVariant.filled
                        ? Colors.white
                        : theme.colorScheme.primary),
              ),
            ),
          ),
          SizedBox(width: iconGap),
          Flexible(child: label), // ✅ here Flexible is valid (inside Row)
        ],
      );
    }

    if (iconW != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children:
            iconPosition == IconPosition.start
                ? [iconW, SizedBox(width: iconGap), Flexible(child: label)]
                : [Flexible(child: label), SizedBox(width: iconGap), iconW],
      );
    }

    return label; // ✅ no Flexible here
  }

  @override
  Widget build(BuildContext context) {
    final style = _buildStyle(context);
    final child = _buildChild(context);

    final button = switch (variant) {
      ButtonVariant.filled => ElevatedButton(
        onPressed: _enabled ? onPressed : null,
        style: style,
        autofocus: autofocus,
        focusNode: focusNode,
        child: child,
      ),
      ButtonVariant.outline => OutlinedButton(
        onPressed: _enabled ? onPressed : null,
        style: style,
        autofocus: autofocus,
        focusNode: focusNode,
        child: child,
      ),
      ButtonVariant.text => TextButton(
        onPressed: _enabled ? onPressed : null,
        style: style,
        autofocus: autofocus,
        focusNode: focusNode,
        child: child,
      ),
    };

    if (expand) {
      return SizedBox(width: double.infinity, child: button);
    }
    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }
    return button;
  }
}

class OutlinePillButton extends StatelessWidget {
  const OutlinePillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 44, // slim like the mock
    this.borderWidth = 4.5, // thin green outline
    this.horizontalPadding = 24,
  });

  final String label;
  final VoidCallback onPressed;
  final double height;
  final double borderWidth;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.green,
          side: BorderSide(color: AppColors.green, width: 4.5),
          shape: const StadiumBorder(),
          // full pill
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          textStyle: TextStyle(
            color: AppColors.green,
            fontSize: tertiary(), // matches your scale
            fontWeight: FontWeight.w600, // same weight as mock
          ),
          minimumSize: Size.zero,
          // no extra height padding
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(label, style: TextStyle(color: AppColors.green)),
      ),
    );
  }
}
