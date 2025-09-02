import 'dart:convert';

import 'package:estate2/components/gap.dart';
import 'package:estate2/constant/colors.dart';
import 'package:estate2/constant/constant.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title:
              const Text("My Favorites", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor),
      body: Constant.favoriteEstates.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: Constant.favoriteEstates.length,
              itemBuilder: (context, index) {
                final estate = Constant.favoriteEstates[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(16),
                        ),
                        child: Image.network(
                          estate["image"],
                          width: width * 0.35,
                          height: height * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                estate["title"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(isWidth: false, isHeight: true, height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      estate["location"],
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(isWidth: false, isHeight: true, height: 5),
                              Text(
                                estate["price"],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Constant.favoriteEstates.removeAt(index);
                          setState(() {});
                          await Constant.preferences!.setString("favorites",
                              jsonEncode(Constant.favoriteEstates));
                        },
                        icon: const Icon(Icons.favorite, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
