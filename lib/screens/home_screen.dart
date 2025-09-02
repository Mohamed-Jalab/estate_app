import 'package:estate2/components/app_input.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/components/home/featured_card.dart';
import 'package:estate2/components/home/home_category.dart';
import 'package:estate2/components/home/home_header.dart';
import 'package:estate2/components/home/property_card.dart';
import 'package:estate2/components/home/row_title_home.dart';
import 'package:estate2/components/home/top_agent.dart';
import 'package:estate2/components/home/top_location.dart';
import 'package:estate2/constant/colors.dart';
import 'package:estate2/models/estate_model.dart';
import 'package:estate2/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../blocs/estate_bloc/estate_bloc.dart';
import '../constant/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchInput = TextEditingController();
  final searchFocus = FocusNode();
  List<bool> selectedTypes = [];

  @override
  void dispose() {
    searchInput.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final smallGapW = width * 0.03;
    final mediumGapW = width * 0.05;
    final smallGapH = height * 0.02;
    final mediumGapH = height * 0.03;
    EstateBloc bloc = context.read<EstateBloc>();
    List<EstateModel> filteredEstates = bloc.estates.where((estate) {
      final List<String> types = [];
      for (int i = 0; i < bloc.estateTypes.length; i++)
        if (selectedTypes[i]) types.add(bloc.estateTypes[i]);

      return types.contains(estate.estateType);
    }).toList();

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<EstateBloc, EstateState>(
          buildWhen: (previous, current) =>
              current is EstateSuccess ||
              current is EstateLoading ||
              current is EstateFailure,
          listener: (context, state) {
            if (state is EstateFailure) {
              Fluttertoast.showToast(msg: state.message);
            }
            if (state is EstateSuccess) {
              selectedTypes =
                  List.generate(bloc.estateTypes.length, (_) => true);
              filteredEstates = bloc.estates.where((estate) {
                final List<String> types = [];
                for (int i = 0; i < bloc.estateTypes.length; i++)
                  if (selectedTypes[i]) types.add(bloc.estateTypes[i]);

                return types.contains(estate.estateType);
              }).toList();
            }
          },
          builder: (context, state) {
            print("home");
            print(state);
            print(context.read<EstateBloc>().estates.length);
            EstateBloc bloc = context.read<EstateBloc>();
            if (state is EstateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is EstateFailure) {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Try Again"),
                  ElevatedButton(
                      onPressed: () {
                        context.read<EstateBloc>().add(GetAllEstates());
                      },
                      child: Text("Try"))
                ],
              ));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<EstateBloc>().add(GetAllEstates());
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeader(),
                      const Gap(
                        isWidth: false,
                        isHeight: true,
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text("Hey",
                              style: Theme.of(context).textTheme.displayLarge),
                          Gap(isWidth: true, isHeight: false, width: smallGapW),
                          Text(
                            Constant.user!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      Text("Let's start exploring",
                          style: Theme.of(context).textTheme.displaySmall),
                      Gap(isWidth: false, isHeight: true, height: mediumGapH),
                      //! Search Bar
                      AppInput(
                        myController: searchInput,
                        focusNode: searchFocus,
                        onFiledSubmitedValue: (value) {},
                        keyBoardType: TextInputType.text,
                        leftIcon: true,
                        icon: const Icon(Icons.search),
                        isFilled: true,
                        obscureText: false,
                        hinit: "Find location...",
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          controller.jumpToTab(1);
                        },
                        onValidator: (value) {
                          if (value.isEmpty) return;
                          return null;
                        },
                      ),
                      Gap(isWidth: false, isHeight: true, height: mediumGapH),
                      //! Filters
                      SizedBox(
                        height: height / 12,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: bloc.estateTypes.length,
                          itemBuilder: (context, index) => HomeCategory(
                            title: bloc.estateTypes[index],
                            active: selectedTypes[index],
                            onTap: () {
                              print(selectedTypes[index]);
                              setState(() {
                                selectedTypes[index] = !selectedTypes[index];
                              });
                            },
                          ),

                          separatorBuilder: (context, index) => Gap(
                              isWidth: true, isHeight: false, width: smallGapW),
                          // children: [
                          //   const HomeCategory(title: "All", active: true),
                          //   const HomeCategory(title: "House", active: false),
                          //   Gap(
                          //       isWidth: true,
                          //       isHeight: false,
                          //       width: smallGapW),
                          //   const HomeCategory(
                          //       title: "Townhouse", active: false),
                          //   Gap(
                          //       isWidth: true,
                          //       isHeight: false,
                          //       width: smallGapW),
                          //   const HomeCategory(
                          //       title: "Apparment", active: false),
                          //   Gap(
                          //       isWidth: true,
                          //       isHeight: false,
                          //       width: smallGapW),
                          //   const HomeCategory(title: "Condo", active: false),
                          // ],
                        ),
                      ),
                      Gap(isWidth: false, isHeight: true, height: smallGapH),
                      //! Houses
                      SizedBox(
                        height: height / 4,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredEstates.length,
                          itemBuilder: (context, index) {
                            return PropertyCard(
                              id: filteredEstates[index].id,
                              title: filteredEstates[index].title,
                              location: filteredEstates[index].address,
                              rating: filteredEstates[index].rateAvg.toDouble(),
                              area: filteredEstates[index].area.toDouble(),
                              //! must be network image but the server is not working
                              imageUrl:
                                  "lib/assets/images/property${(index % 2) + 1}.jpg",
                              price: filteredEstates[index].price.toString(),
                              description: filteredEstates[index].description,
                              isBig: false,
                              //! must be network image but the server is not working
                              isNetwork: false,
                            );
                          },
                          separatorBuilder: (context, index) => Gap(
                              isWidth: true, isHeight: false, width: smallGapH),
                          // [
                          //   const PropertyCard(
                          //     title: "Halloween Sale!",
                          //     location: "New York",
                          //     imageUrl: "lib/assets/images/property2.jpg",
                          //     price: "\$500,000",
                          //     description: "Spacious 3-bedroom house",
                          //     isBig: false,
                          //     isNetwork: false,
                          //   ),
                          //   Gap(isWidth: true, isHeight: false, width: smallGapH),
                          //   const PropertyCard(
                          //     title: "Townhouse Sale!",
                          //     location: "California",
                          //     imageUrl: "lib/assets/images/property1.jpg",
                          //     price: "\$350,000",
                          //     description: "Modern townhouse with garden",
                          //     isBig: false,
                          //     isNetwork: false,
                          //   ),
                          //   Gap(isWidth: true, isHeight: false, width: mediumGapW),
                          //   const PropertyCard(
                          //       title: "Summer Vacation",
                          //       location: "Florida",
                          //       imageUrl: "lib/assets/images/slider6.png",
                          //       price: "\$450,000",
                          //       description: "Beachfront summer house",
                          //       isBig: false,
                          //       isNetwork: false),
                          // ],
                        ),
                      ),
                      Gap(isWidth: false, isHeight: true, height: smallGapH),
                      RowTitleHome(
                          title: "Featured Estates",
                          subtitle: "view all",
                          onPress: () {}),
                      Gap(isWidth: false, isHeight: true, height: smallGapH),
                      //! Estates
                      SizedBox(
                        height: height / 4,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const FeaturedCard(
                              price: 65000,
                              path: "lib/assets/images/property2.jpg",
                              category: "Appartment",
                              title: "Aura\nApartment",
                              rating: 4.5,
                              location: "Pabna, Bangladesh",
                              payment: "10",
                            ),
                            Gap(
                              isWidth: true,
                              isHeight: false,
                              width: mediumGapW,
                            ),
                            const FeaturedCard(
                              price: 60000,
                              path: "lib/assets/images/property1.jpg",
                              category: "Appartment",
                              title: "The Nexus\nApartment",
                              rating: 4.9,
                              location: "Pabna, Bangladesh",
                              payment: "10",
                            ),
                            Gap(
                              isWidth: true,
                              isHeight: false,
                              width: mediumGapW,
                            ),
                            const FeaturedCard(
                              path: "lib/assets/images/property.jpg",
                              category: "Appartment",
                              title: "Monolith Manor\nApartment",
                              rating: 4.6,
                              price: 90000,
                              location: "Pabna, Bangladesh",
                              payment: "10",
                            ),
                          ],
                        ),
                      ),
                      Gap(isWidth: false, isHeight: true, height: smallGapH),
                      RowTitleHome(
                          title: "Top Locations",
                          subtitle: "explore",
                          onPress: () {}),
                      Gap(isWidth: false, isHeight: true, height: smallGapH),
                      //! Locations
                      SizedBox(
                        height: height / 15,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const TopLocation(
                                path: "lib/assets/images/property.jpg",
                                location: "Bali"),
                            Gap(
                                isWidth: true,
                                isHeight: false,
                                width: smallGapW),
                            const TopLocation(
                                path: "lib/assets/images/property1.jpg",
                                location: "Jakartha"),
                            Gap(
                                isWidth: true,
                                isHeight: false,
                                width: smallGapW),
                            const TopLocation(
                                path: "lib/assets/images/property2.jpg",
                                location: "Yogartha"),
                            Gap(
                                isWidth: true,
                                isHeight: false,
                                width: smallGapW),
                          ],
                        ),
                      ),
                      Gap(isWidth: false, isHeight: true, height: mediumGapH),
                      RowTitleHome(
                          title: "Top Estate Agents",
                          subtitle: "explore",
                          onPress: () {}),
                      Gap(isWidth: false, isHeight: true, height: smallGapH),
                      //! Top Agents
                      SizedBox(
                        height: height / 8,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const TopAgent(
                                path: "lib/assets/images/profile.png",
                                name: "Amanda"),
                            Gap(
                              isWidth: true,
                              isHeight: false,
                              width: smallGapW,
                            ),
                            const TopAgent(
                              path: "lib/assets/images/profile1.png",
                              name: "Andserson",
                            ),
                            Gap(
                              isWidth: true,
                              isHeight: false,
                              width: smallGapW,
                            ),
                            const TopAgent(
                              path: "lib/assets/images/profile2.png",
                              name: "Samantha",
                            ),
                          ],
                        ),
                      ),
                      Gap(isWidth: false, isHeight: true, height: mediumGapH),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
