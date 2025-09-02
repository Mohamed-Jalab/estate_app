import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:estate2/components/app_button.dart';
import 'package:estate2/components/app_padding.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/components/header_title.dart';
import 'package:estate2/constant/colors.dart';
import 'package:estate2/utils/route_name.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class AccountEmptyScreen extends StatefulWidget {
  const AccountEmptyScreen({super.key});

  @override
  State<AccountEmptyScreen> createState() => _AccountEmptyScreenState();
}

class _AccountEmptyScreenState extends State<AccountEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final bloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: AppPadding(
            padddingValue: 15,
            child: Column(
              children: [
                const HeaderTitle(
                    title: "Add your ",
                    bottomTitle:
                        "You can edit this later on your account setting.",
                    subtitle: "location"),
                Gap(isWidth: false, isHeight: true, height: height * 0.03),
                Container(
                  width: double.infinity,
                  height: height * 0.35,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: GoogleMap(
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(34.8021, 38.9968), zoom: 6),
                      mapType: MapType.hybrid),
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.04),
                InkWell(
                  onTap: () async {
                    LatLng? latLng = await Navigator.of(context)
                        .pushNamed(RoutesName.accountLocationScreen) as LatLng?;
                    if (latLng == null) return;
                    bloc.userModel.latitude = latLng.latitude.toString();
                    bloc.userModel.longitude = latLng.longitude.toString();
                  },
                  child: Container(
                    height: height * 0.08,
                    decoration: BoxDecoration(
                        color: AppColors.inputBackground,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Gap(
                                isWidth: true, isHeight: false, width: 10),
                            const Icon(
                              Icons.location_pin,
                              color: AppColors.textPrimary,
                              size: 20,
                            ),
                            const Gap(
                                isWidth: true, isHeight: false, width: 10),
                            Text(
                              "Location details",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.textPrimary),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.chevron_right_sharp,
                              color: AppColors.textPrimary,
                            ),
                            Gap(isWidth: true, isHeight: false, width: 10),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.1),
                AppButton(
                    onPress: () {
                      if (bloc.userModel.latitude != null) {
                        Navigator.pushNamed(
                            context, RoutesName.galleryGridView);
                      } else {
                        Fluttertoast.showToast(msg: "must pick your location");
                      }
                    },
                    title: "Next",
                    textColor: AppColors.whiteColor,
                    height: 60)
              ],
            )),
      ),
    );
  }
}
