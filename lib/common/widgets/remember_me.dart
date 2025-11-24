import 'package:flutter/material.dart';

class RememberMe extends StatelessWidget {
  final bool value;
  final VoidCallback? onTab;

  const RememberMe({
    super.key,
    required this.value,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.black,
                width: 1.4,
              ),
              color: value
                  ? Colors.blue
                  : Colors.transparent,
            ),
            child: value
                ? Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 6),
          const Text(
            'Remember me',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
