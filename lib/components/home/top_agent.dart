import 'package:flutter/material.dart';

class TopAgent extends StatelessWidget {
  final String path, name;
  const TopAgent({super.key, required this.name, required this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(path),
        ),
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
        )
      ],
    );
  }
}
