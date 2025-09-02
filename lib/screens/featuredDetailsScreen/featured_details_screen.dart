import 'package:flutter/material.dart';
import 'package:estate2/components/shared/screen.dart';

class FeaturedDetailsScreen extends StatefulWidget {
  const FeaturedDetailsScreen({super.key});

  @override
  State<FeaturedDetailsScreen> createState() => _FeaturedDetailsScreenState();
}

class _FeaturedDetailsScreenState extends State<FeaturedDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      isBackButton: false,
      child: Text("featured_details"),
    );
  }
}
