import 'dart:async';

import 'package:estate2/components/app_button.dart';
import 'package:estate2/components/app_input.dart';
import 'package:estate2/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AccountLocationScreen extends StatefulWidget {
  const AccountLocationScreen({super.key});

  @override
  State<AccountLocationScreen> createState() => _AccountLocationScreenState();
}

class _AccountLocationScreenState extends State<AccountLocationScreen> {
  final searchInput = TextEditingController();
  final searchFocus = FocusNode();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};
  @override
  void dispose() {
    super.dispose();
    searchInput.dispose();
    searchFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(34.8021, 38.9968), zoom: 6),
            onMapCreated: (controller) => _controller.complete(controller),
            onTap: (latLng) async {
              setState(() {
                markers.add(
                    Marker(markerId: MarkerId("location"), position: latLng));
              });
              (await _controller.future).animateCamera(
                  CameraUpdate.newCameraPosition(
                      CameraPosition(target: latLng, zoom: 18)));
            },
            markers: markers),
        Positioned(
          top: 50,
          left: 10,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left_sharp,
                size: 30, color: AppColors.textPrimary),
          ),
        ),
        Positioned(
            top: 100,
            left: 10,
            right: 20,
            child: AppInput(
                myController: searchInput,
                focusNode: searchFocus,
                onFiledSubmitedValue: (value) {},
                keyBoardType: TextInputType.text,
                leftIcon: true,
                icon: Icon(Icons.search),
                otherColor: true,
                isFilled: true,
                obscureText: false,
                hinit: "Find location...",
                onValidator: (value) {
                  if (value.isEmpty) return;
                  return null;
                })),
        Positioned(
          bottom: 100,
          left: 10,
          right: 20,
          child: AppButton(
            onPress: () {
              if (markers.isNotEmpty) {
                Navigator.of(context).pop(markers.first.position);
              }
            },
            title: "Choose your location",
            height: 65,
            textColor: AppColors.whiteColor,
            radius: 15,
          ),
        )
      ],
    ));
  }
}
