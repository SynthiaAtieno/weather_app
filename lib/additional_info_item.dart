import 'package:flutter/material.dart';


class AdditionalInfoItem extends StatelessWidget {
  const AdditionalInfoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.water_drop, size: 32),
        SizedBox(height: 16),
        Text("Humidity"),
        SizedBox(height: 16),
        Text("94")
      ],
    );
  }
}
