import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const CustomToggleButton({
    super.key,
    this.initialValue = true,
    this.onChanged,
  });

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _value,
      activeColor: Colors.white,
      inactiveThumbColor: Colors.white,
      activeTrackColor: const Color(0xFF6A7D35),
      inactiveTrackColor: const Color(0xFFE7E2E2),
      onChanged: (val) {
        setState(() => _value = val);
        if (widget.onChanged != null) widget.onChanged!(val);
      },
    );
  }
}
