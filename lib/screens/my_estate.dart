import 'package:estate2/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../blocs/estate_bloc/estate_bloc.dart';
import '../components/gap.dart';
import '../constant/constant.dart';
import '../models/estate_model.dart';
import 'add_estate.dart';
import 'property/property_details_page.dart';

class MyEstates extends StatefulWidget {
  const MyEstates({super.key, required this.estates, required this.myPending});
  final List<EstateModel> estates;
  final List<EstateModel> myPending;

  @override
  State<MyEstates> createState() => _MyEstatesState();
}

class _MyEstatesState extends State<MyEstates> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Estates"), centerTitle: true),
        body: SafeArea(
          child: Scaffold(
            floatingActionButton: isLoading
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddEstate()));
                    },
                    child: Icon(Icons.add)),
            body: widget.estates.isEmpty
                ? Center(child: Text("There is no estate"))
                : isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount:
                            widget.estates.length + widget.estates.length,
                        itemBuilder: (context, index) =>index< widget.estates.length-1?  Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: PropertyMyCard(
                                estateType: widget.estates[index].estateType,
                                rooms: widget.estates[index].roomsCount ?? '0',
                                id: widget.estates[index].id,
                                title: widget.estates[index].title,
                                location: widget.estates[index].address,
                                rating:
                                    widget.estates[index].rateAvg.toDouble(),
                                area: widget.estates[index].area.toDouble(),
                                lat: widget.estates[index].lat,
                                lon: widget.estates[index].lon,
                                imageUrl:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGS-nS14Fm9zhEQegRDRIkYUlhivdaJDNUeg&s",
                                price: widget.estates[index].price.toString(),
                                description: widget.estates[index].description,
                                listingType: widget.estates[index].listingType,
                                isBig: false,
                                isNetwork: true,
                              ),
                            )),
          ),
        ));
  }
}

class PropertyMyCard extends StatelessWidget {
  final int id;
  final String title;
  final String location;
  final String imageUrl;
  final String price;
  final String description;
  final bool isBig;
  final bool isNetwork;
  final num lat;
  final num lon;

  final double area;
  final int bedrooms;
  final int bathrooms;
  final double rating;
  final String rooms;
  final String sallerName;
  final String sallerPhone;
  final String listingType;
  final String estateType;
  const PropertyMyCard({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.estateType,
    required this.price,
    required this.description,
    required this.isBig,
    required this.isNetwork,
    required this.area,
    required this.listingType,
    required this.lat,
    required this.lon,
    required this.rooms,
    this.bedrooms = 3,
    this.bathrooms = 2,
    required this.rating,
    this.sallerName = "Ahmed",
    this.sallerPhone = "098755433",
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final double height = isBig ? 280 : 200;
    final double width = isBig ? 300 : 240;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsPage(
              id: id,
              title: title,
              description: description,
              imageUrl: imageUrl,
              location: location,
              price: price,
              isNetwork: isNetwork,
              area: area,
              bedrooms: bedrooms,
              bathrooms: bathrooms,
              rating: rating,
              sallerName: sallerName,
              sallerPhone: sallerPhone,
              listingType: listingType,
            ),
          ),
        );
      },
      child: Container(
        height: 300,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: isNetwork
                  ? Image.network(
                      imageUrl,
                      height: isBig ? 180 : 120,
                      width: width,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imageUrl,
                      height: isBig ? 180 : 120,
                      width: width,
                      fit: BoxFit.cover,
                    ),
            ),
            const Gap(isWidth: false, isHeight: true, height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                location,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddEstate(
                                  id: id,
                                  title: title,
                                  description: description,
                                  address: location,
                                  area: area.toInt(),
                                  lat: lat.toDouble(),
                                  lon: lon.toDouble(),
                                  listingType: listingType,
                                  price: int.tryParse(price),
                                  rooms: int.tryParse(rooms),
                                  estateType: estateType,
                                )));
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        bool isLoading = false;
                        await showDialog(
                            context: context,
                            builder: (_) =>
                                StatefulBuilder(builder: (context, setState) {
                                  return AlertDialog(
                                      title: Text("Rate this estate"),
                                      content: Text(
                                          "Are you sure to delete this estate"),
                                      actions: [
                                        if (isLoading)
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        if (!isLoading)
                                          TextButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }),
                                        if (!isLoading)
                                          TextButton(
                                              child: Text("Yes"),
                                              onPressed: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                await deleteEstate(id);
                                                if (context.mounted) {
                                                  context
                                                      .read<EstateBloc>()
                                                      .add(GetAllEstates());
                                                  Navigator.of(context)..pop();
                                                }
                                              }),
                                      ]);
                                }));
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteEstate(int estateId) async {
    final headers = {'Authorization': Constant.token!};
    Response res = await delete(
        Uri.parse("${Constant.baseUrl}/estate/$estateId"),
        headers: headers);
    print(res.statusCode);
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: "Delete it successfully");
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
