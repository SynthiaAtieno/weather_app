import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final double valuetxt;
  const AdditionalInfoItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.valuetxt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 16),
        Text(label),
        const SizedBox(height: 16),
        Text(valuetxt.toString())
      ],
    );
  }
}
