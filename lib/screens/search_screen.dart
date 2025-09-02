import 'package:estate2/components/gap.dart';
import 'package:estate2/components/home/property_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../blocs/estate_bloc/estate_bloc.dart';
import '../models/estate_model.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  double maxPrice = 0;
  double minPrice = 0;
  double maxArea = 0;
  double minArea = 0;
  List<EstateModel> filteredProperties = [];
  String selectedLocation = 'All';
  String selectedType = 'All'; // 👈 نوع العقار: الكل، شراء، إيجار
  bool isGrid = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    maxPrice = context.read<EstateBloc>().maxPrice.toDouble();
    minPrice = context.read<EstateBloc>().minPrice.toDouble();
    maxArea = context.read<EstateBloc>().maxArea.toDouble();
    minArea = context.read<EstateBloc>().minArea.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final query = (searchController.text).trim().toLowerCase();

    final filteredProperties =
        context.read<EstateBloc>().estates.where((property) {
      final title = (property.title).toString().toLowerCase();
      final location = (property.address).toString().toLowerCase();
      final type = (property.listingType).toString().toLowerCase();

      final matchesQuery =
          query.isEmpty || title.contains(query) || location.contains(query);
      final matchesLocation = selectedLocation == 'All' ||
          location == selectedLocation.toLowerCase();
      final matchesType = selectedType == 'All' || type == selectedType;

      final priceMatches =
          property.price <= maxPrice && property.price >= minPrice;
      final areaMatches = property.area <= maxArea && property.area >= minArea;

      return matchesQuery &&
          matchesLocation &&
          priceMatches &&
          matchesType &&
          areaMatches;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          )
        ],
      ),
      body: BlocConsumer<EstateBloc, EstateState>(
        buildWhen: (previous, current) =>
            current is EstateSuccess ||
            current is EstateLoading ||
            current is EstateFailure,
        listener: (context, state) {
          if (state is EstateFailure) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          EstateBloc bloc = context.read<EstateBloc>();
          if (state is EstateLoading) {
            return Center(child: CircularProgressIndicator());
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
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search by name or location',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.green.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Gap(isWidth: false, isHeight: true, height: 10),
                Row(
                  children: [
                    const Text(
                      "Price:",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: RangeSlider(
                        min: bloc.minPrice.toDouble(),
                        max: bloc.maxPrice.toDouble(),
                        values: RangeValues(
                            minPrice.toDouble(), maxPrice.toDouble()),
                        labels: RangeLabels(
                            "\$${minPrice.round()}", "\$${maxPrice.round()}"),
                        onChanged: (value) {
                          setState(() {
                            minPrice = value.start;
                            maxPrice = value.end;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(children: [
                  SizedBox(width: 50),
                  Text("\$${minPrice.round()}"),
                  Spacer(),
                  Text("\$${maxPrice.round()}"),
                  SizedBox(width: 20)
                ]),
                const Gap(isWidth: false, isHeight: true, height: 10),
                Row(
                  children: [
                    const Text(
                      "Area:",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: RangeSlider(
                        min: bloc.minArea.toDouble(),
                        max: bloc.maxArea.toDouble(),
                        values:
                            RangeValues(minArea.toDouble(), maxArea.toDouble()),
                        labels: RangeLabels(
                            "\$${minArea.round()}", "\$${maxArea.round()}"),
                        onChanged: (value) {
                          setState(() {
                            minArea = value.start;
                            maxArea = value.end;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(children: [
                  SizedBox(width: 50),
                  Text("${minArea.round()}"),
                  Spacer(),
                  Text("${maxArea.round()}"),
                  SizedBox(width: 20)
                ]),
                const Gap(isWidth: false, isHeight: true, height: 10),
                Row(
                  children: [
                    const Text(
                      "Location: ",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedLocation,
                      items: ['All', ...bloc.addresses]
                          .map(
                            (location) => DropdownMenuItem(
                                value: location, child: Text(location)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value!;
                        });
                      },
                    ),
                  ],
                ),
                const Gap(isWidth: false, isHeight: true, height: 10),
                Row(
                  children: [
                    const Text(
                      "Estate type: ",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedType,
                      items: ['All', ...bloc.types].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                  ],
                ),
                const Gap(isWidth: false, isHeight: true, height: 12),
                Expanded(
                  child: isGrid
                      ? RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(GetAllEstates());
                          },
                          child: GridView.builder(
                            itemCount: filteredProperties.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return PropertyCard(
                                id: filteredProperties[index].id,
                                title: filteredProperties[index].title,
                                location: filteredProperties[index].address,
                                rating: filteredProperties[index]
                                    .rateAvg
                                    .toDouble(),
                                area: filteredProperties[index].area.toDouble(),
                                imageUrl:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGS-nS14Fm9zhEQegRDRIkYUlhivdaJDNUeg&s",
                                price:
                                    filteredProperties[index].price.toString(),
                                description:
                                    filteredProperties[index].description,
                                isBig: false,
                                isNetwork: true,
                              );
                            },
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(GetAllEstates());
                          },
                          child: ListView.builder(
                            itemCount: filteredProperties.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: PropertyCard(
                                  id: filteredProperties[index].id,
                                  title: filteredProperties[index].title,
                                  location: filteredProperties[index].address,
                                  rating: filteredProperties[index]
                                      .rateAvg
                                      .toDouble(),
                                  area:
                                      filteredProperties[index].area.toDouble(),
                                  imageUrl:
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGS-nS14Fm9zhEQegRDRIkYUlhivdaJDNUeg&s",
                                  price: filteredProperties[index]
                                      .price
                                      .toString(),
                                  description:
                                      filteredProperties[index].description,
                                  isBig: false,
                                  isNetwork: true,
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
