import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hint;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final Widget? suffix;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 19, 19, 19),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                dropdownColor: const Color(0xFF1C1C1C),
                isExpanded: suffix == null,
                value: value,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'GoogleSans',
                ),
                hint: Text(
                  hint,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontFamily: 'GoogleSans',
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
