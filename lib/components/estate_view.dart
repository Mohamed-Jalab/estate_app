import 'package:flutter/material.dart';
import 'package:estate2/components/accordion.dart';

class EstateView extends StatelessWidget {
  const EstateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        child: const AccordionApp(),
      ),
    );
  }
}
