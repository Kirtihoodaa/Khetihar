import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

enum AllowedType {
  text, // letters + spaces + common punctuation
  numeric, // integers only
  decimal, // numbers with decimals
  textNumeric, // letters + numbers (optional spaces)
  email,
  phone,
  uppercaseAlphaNum, // A-Z + 0-9 (no spaces)
}

class CustomInputField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final bool isDatePicker;
  final Widget? child;
  final String? initialValue;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  final int? maxLines;
  final bool readOnly;
  final bool enabled;

  // type control
  final AllowedType allowedType;
  final int? maxLength;

  //  numeric constraints
  final num? minNumber;
  final num? maxNumber;
  final int decimalPlaces;
  final bool allowNegative;
  final bool allowSpaces;

  const CustomInputField({
    super.key,
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
    this.isDatePicker = false,
    this.child,
    this.initialValue,
    this.onChanged,
    this.maxLines,
    this.readOnly = false,
    this.inputFormatters,
    this.width,
    this.enabled = true,

    // type defaults
    this.allowedType = AllowedType.text,
    this.maxLength,

    // numeric defaults
    this.minNumber,
    this.maxNumber,
    this.decimalPlaces = 2,
    this.allowNegative = false,
    this.allowSpaces = true,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder:
          (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.green,
                onPrimary: AppColors.grey,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: AppColors.green),
              ),
            ),
            child: child!,
          ),
    );
    if (picked != null && widget.controller != null) {
      final formatted =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      widget.controller!.text = formatted;
      widget.onChanged?.call(formatted);
    }
  }

  // ---------- Type helpers ----------
  TextInputType _resolvedKeyboardType() {
    if (widget.keyboardType != null) return widget.keyboardType!;
    switch (widget.allowedType) {
      case AllowedType.numeric:
        return TextInputType.number;
      case AllowedType.decimal:
        return const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        );
      case AllowedType.email:
        return TextInputType.emailAddress;
      case AllowedType.phone:
        return TextInputType.phone;
      default:
        return (widget.maxLines != null && widget.maxLines! > 1)
            ? TextInputType.multiline
            : TextInputType.text;
    }
  }

  List<TextInputFormatter> _resolvedFormatters() {
    final List<TextInputFormatter> list = [];

    // Max length
    if (widget.maxLength != null) {
      list.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }

    // Base by allowedType
    switch (widget.allowedType) {
      case AllowedType.numeric:
        // ^-?\d*$
        final neg = widget.allowNegative ? r'-?' : '';
        list.add(FilteringTextInputFormatter.allow(RegExp('^$neg\\d*\$')));
        break;

      case AllowedType.decimal:
        // ^-?\d*([.]\d{0,N})?$
        final neg = widget.allowNegative ? r'-?' : '';
        final dp = widget.decimalPlaces;
        list.add(
          FilteringTextInputFormatter.allow(
            RegExp('^$neg\\d*(?:[\\.]\\d{0,$dp})?\$'),
          ),
        );
        break;

      case AllowedType.textNumeric:
        // letters + digits + spaces (optional)
        final space = widget.allowSpaces ? ' ' : '';
        list.add(
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9$space]')),
        );
        break;

      case AllowedType.email:
        // allow typical email chars (validation will check full pattern)
        list.add(
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._\-+]')),
        );
        break;

      case AllowedType.phone:
        // + and digits, spaces optional
        final space = widget.allowSpaces ? ' ' : '';
        list.add(FilteringTextInputFormatter.allow(RegExp('[0-9+$space]')));
        break;

      case AllowedType.uppercaseAlphaNum:
        list.add(FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')));
        break;

      case AllowedType.text:
      default:
        // Letters, common punctuation, spaces (toggle)
        final space = widget.allowSpaces ? ' ' : '';
        list.add(
          FilteringTextInputFormatter.allow(
            RegExp("[a-zA-Z$space.,'\"\\-_/()!]"),
          ),
        );
        break;
    }

    // User-provided extra formatters (applied last)
    if (widget.inputFormatters != null) {
      list.addAll(widget.inputFormatters!);
    }
    return list;
  }

  String? _typeValidator(String? value) {
    final v = (value ?? '').trim();
    if (!widget.enabled) return null;

    // If it's a datePicker field, we don't validate type here
    if (widget.isDatePicker) return null;

    // Empty is OK unless caller’s validator forbids it
    if (v.isEmpty) return null;

    switch (widget.allowedType) {
      case AllowedType.numeric:
        final neg = widget.allowNegative ? r'-?' : '';
        if (!RegExp('^$neg\\d+\$').hasMatch(v)) {
          return 'Please enter a valid number';
        }
        final n = int.tryParse(v);
        if (n == null) return 'Please enter a valid number';
        if (widget.minNumber != null && n < widget.minNumber!) {
          return 'Must be ≥ ${widget.minNumber}';
        }
        if (widget.maxNumber != null && n > widget.maxNumber!) {
          return 'Must be ≤ ${widget.maxNumber}';
        }
        break;

      case AllowedType.decimal:
        final neg = widget.allowNegative ? r'-?' : '';
        final dp = widget.decimalPlaces;
        if (!RegExp('^$neg\\d+(?:[\\.]\\d{1,$dp})?\$').hasMatch(v)) {
          return 'Please enter a valid number (up to $dp decimals)';
        }
        final n = double.tryParse(v);
        if (n == null) return 'Please enter a valid number';
        if (widget.minNumber != null && n < widget.minNumber!) {
          return 'Must be ≥ ${widget.minNumber}';
        }
        if (widget.maxNumber != null && n > widget.maxNumber!) {
          return 'Must be ≤ ${widget.maxNumber}';
        }
        break;

      case AllowedType.email:
        // Simple but robust email pattern
        final emailRe = RegExp(
          r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
        );
        if (!emailRe.hasMatch(v)) return 'Please enter a valid email address';
        break;

      case AllowedType.phone:
        // Basic phone: starts with + optional, 7–15 digits
        final phoneRe = RegExp(r'^\+?\d{7,15}$');
        if (!phoneRe.hasMatch(v.replaceAll(' ', ''))) {
          return 'Please enter a valid phone number';
        }
        break;

      case AllowedType.uppercaseAlphaNum:
        if (!RegExp(r'^[A-Z0-9]+$').hasMatch(v)) {
          return 'Use uppercase letters and digits only';
        }
        break;

      case AllowedType.textNumeric:
        if (!RegExp(r'^[A-Za-z0-9 ]+$').hasMatch(v)) {
          return 'Only letters, numbers, and spaces are allowed';
        }
        break;

      case AllowedType.text:
      default:
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: SizedBox(
          width: widget.width ?? double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyBorder),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.grey,
            ),
            child: widget.child!,
          ),
        ),
      );
    }

    final formatters = _resolvedFormatters();
    final kType = _resolvedKeyboardType();

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        child: TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          keyboardType:
              (widget.maxLines != null && widget.maxLines! > 1)
                  ? TextInputType.multiline
                  : kType,
          obscureText: _obscure,
          maxLines: widget.maxLines ?? 1,
          inputFormatters: formatters,
          validator: (val) {
            // 1) Type-level validation
            final typeErr = _typeValidator(val);
            if (typeErr != null) return typeErr;

            // 2) Custom validator (if provided)
            if (widget.validator != null) {
              return widget.validator!(val);
            }
            return null;
          },
          textInputAction:
              (widget.maxLines != null && widget.maxLines! > 1)
                  ? TextInputAction.newline
                  : TextInputAction.done,
          textAlignVertical:
              (widget.maxLines != null && widget.maxLines! > 1)
                  ? TextAlignVertical.top
                  : TextAlignVertical.center,
          readOnly: widget.readOnly || widget.isDatePicker,
          onTap: widget.isDatePicker ? () => _selectDate(context) : null,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.grey,
            hintText: widget.labelText,
            counterText: '', // hide default counter when maxLength used
            contentPadding:
                (widget.maxLines != null && widget.maxLines! > 1)
                    ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                    : const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            suffixIcon:
                widget.isDatePicker
                    ? const Icon(Icons.calendar_today, color: AppColors.green)
                    : widget.obscureText
                    ? IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.grey,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    )
                    : null,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.greyBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.greyBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.green, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

Widget labelText(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, bottom: 5),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: tertiary(),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
  );
}
