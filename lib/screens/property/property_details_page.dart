import 'dart:convert';

import 'package:estate2/components/gap.dart';
import 'package:estate2/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/estate_bloc/estate_bloc.dart';
import '../../constant/constant.dart';
import '../../main.dart';

class PropertyDetailsPage extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String location;
  final String price;
  final double area;
  final int bedrooms;
  final int bathrooms;
  final double rating;
  final bool isNetwork;
  final String sallerName;
  final String sallerPhone;
  final String propertyType;
  final bool local;

  const PropertyDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.area,
    required this.bedrooms,
    this.local = false,
    required this.bathrooms,
    required this.sallerName,
    required this.sallerPhone,
    required this.propertyType,
    required this.rating,
    this.isNetwork = false,
    required this.id,
  });

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<EstateBloc>().add(GetOneEstate(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (widget.local) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Property Details",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.whiteColor),
          ),
          iconTheme: const IconThemeData(color: AppColors.whiteColor),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.3,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.isNetwork
                        ? NetworkImage(widget.imageUrl)
                        : AssetImage(widget.imageUrl) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Gap(isHeight: true, isWidth: false, height: height * 0.01),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(widget.location,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey[600])),
                        ),
                        IconButton(
                          icon: const Icon(Icons.map,
                              color: AppColors.primaryColor),
                          onPressed: () async {
                            final encodedLocation =
                                Uri.encodeComponent(widget.location);
                            final mapUrl =
                                'https://www.google.com/maps/search/?api=1&query=$encodedLocation';
                            if (await canLaunchUrl(Uri.parse(mapUrl))) {
                              await launchUrl(Uri.parse(mapUrl));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Could not open map")),
                              );
                            }
                          },
                        )
                      ],
                    ),
                    Gap(isHeight: true, isWidth: false, height: height * 0.015),
                    Row(
                      children: [
                        Text("\$${widget.price}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: widget.propertyType == 'rent'
                                ? Colors.orange
                                : Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.propertyType == 'rent'
                                ? 'For Rent'
                                : 'For Sale',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Gap(isHeight: true, isWidth: false, height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFeature(
                            Icons.king_bed, "${widget.bedrooms} Beds"),
                        _buildFeature(
                            Icons.bathtub, "${widget.bathrooms} Baths"),
                        _buildFeature(Icons.square_foot, "${widget.area} m²"),
                      ],
                    ),
                    Gap(isHeight: true, isWidth: false, height: height * 0.02),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: widget.rating,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 24.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 8),
                        Text("(${widget.rating}/5)"),
                        Spacer(),
                      ],
                    ),
                    Gap(isHeight: true, isWidth: false, height: height * 0.03),
                    Text("Description",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                    Gap(isHeight: true, isWidth: false, height: height * 0.01),
                    Text(widget.description,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Gap(isHeight: true, isWidth: false, height: height * 0.04),
                    Text("Seller Info",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                    Gap(isHeight: true, isWidth: false, height: height * 0.01),
                    Text("Name: ${widget.sallerName}"),
                    Text("Phone: ${widget.sallerPhone}"),
                    Gap(isHeight: true, isWidth: false, height: height * 0.02),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                        ),
                        onPressed: () async {
                          final telUrl = "tel:${widget.sallerPhone}";
                          if (await canLaunchUrl(Uri.parse(telUrl))) {
                            await launchUrl(Uri.parse(telUrl));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Could not initiate call")),
                            );
                          }
                        },
                        child: Text("Call Seller",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.whiteColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return BlocConsumer<EstateBloc, EstateState>(
        buildWhen: (previous, current) =>
            current is EstateOneFailure ||
            current is EstateOneSuccess ||
            current is EstateOneLoading,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EstateOneFailure) {
            return Scaffold(
                body: Center(
                    child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Try Again"),
                ElevatedButton(
                  onPressed: () {
                    context.read<EstateBloc>().add(GetOneEstate(id: widget.id));
                  },
                  child: Text("Try Again"),
                )
              ],
            )));
          }
          if (state is EstateOneSuccess) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                title: Text(
                  "Property Details",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.whiteColor),
                ),
                iconTheme: const IconThemeData(color: AppColors.whiteColor),
                actions: [
                  IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => isFavorite(widget.id)
                              ? AlertDialog(
                                  title: Text("Remove from favorite"),
                                  content: Text(
                                      "Are you sure you want to remove this property to your favorite list?"),
                                  actions: [
                                      TextButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      TextButton(
                                          child: Text("Yes"),
                                          onPressed: () async {
                                            int index = 0;
                                            for (index;
                                                index <
                                                    Constant
                                                        .favoriteEstates.length;
                                                index++) {
                                              if (widget.id ==
                                                  Constant.favoriteEstates[
                                                      index]["id"]) {
                                                Constant.favoriteEstates
                                                    .removeAt(index);
                                              }
                                            }
                                            await Constant.preferences!
                                                .setString(
                                                    "favorites",
                                                    jsonEncode(Constant
                                                        .favoriteEstates));
                                            if (context.mounted) {
                                              Navigator.of(context).pop();
                                            }
                                            setState(() {});
                                          })
                                    ])
                              : AlertDialog(
                                  title: Text("Add to favorite"),
                                  content: Text(
                                      "Are you sure you want to add this property to your favorite list?"),
                                  actions: [
                                      TextButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      TextButton(
                                          child: Text("Yes"),
                                          onPressed: () async {
                                            Constant.favoriteEstates.add({
                                              "id": widget.id,
                                              "title": widget.title,
                                              "location": widget.location,
                                              "price": widget.price,
                                              "image":
                                                  "https://media.istockphoto.com/id/1449364000/photo/minimalist-style-tiny-room.jpg?s=612x612&w=0&k=20&c=uokTOpJl8Hoc4HGqJPicYjy8SBMwCEWkGLUhhvJYgTA="
                                            });
                                            await Constant.preferences!
                                                .setString(
                                                    "favorites",
                                                    jsonEncode(Constant
                                                        .favoriteEstates));
                                            if (context.mounted) {
                                              Navigator.of(context).pop();
                                            }
                                            setState(() {});
                                          })
                                    ]));
                    },
                    icon: isFavorite(widget.id)
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Container(
                      height: height * 0.3,
                      width: width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.isNetwork
                              ? NetworkImage(widget.imageUrl)
                              : AssetImage(widget.imageUrl) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.estate.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.01),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 18, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(state.estate.address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.grey[600])),
                              ),
                              IconButton(
                                icon: const Icon(Icons.map,
                                    color: AppColors.primaryColor),
                                onPressed: () async {
                                  final encodedLocation =
                                      Uri.encodeComponent(widget.location);
                                  final mapUrl =
                                      'https://www.google.com/maps/search/?api=1&query=$encodedLocation';
                                  if (await canLaunchUrl(Uri.parse(mapUrl))) {
                                    await launchUrl(Uri.parse(mapUrl));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Could not open map")),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.015),
                          Row(
                            children: [
                              Text("\$${state.estate.price}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold)),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: widget.propertyType == 'rent'
                                      ? Colors.orange
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.propertyType == 'rent'
                                      ? 'For Rent'
                                      : 'For Sale',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildFeature(
                                  Icons.king_bed, "${widget.bedrooms} Beds"),
                              _buildFeature(
                                  Icons.bathtub, "${widget.bathrooms} Baths"),
                              _buildFeature(
                                  Icons.square_foot, "${widget.area} m²"),
                            ],
                          ),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.02),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: state.estate.rateAvg.toDouble(),
                                itemBuilder: (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                itemCount: 5,
                                itemSize: 24.0,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(width: 8),
                              Text("(${state.estate.rateAvg}/5)"),
                              Spacer(),
                              TextButton(
                                  child: Text("rate"),
                                  onPressed: () async {
                                    double rate = 0;
                                    bool isLoading = false;
                                    await showDialog(
                                        context: context,
                                        builder: (_) => StatefulBuilder(
                                                builder: (context, setState) {
                                              return AlertDialog(
                                                  title:
                                                      Text("Rate this estate"),
                                                  content: RatingBar.builder(
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(Icons.star,
                                                            color:
                                                                Colors.amber),
                                                    onRatingUpdate: (rating) {
                                                      setState(() {
                                                        rate = rating;
                                                      });
                                                    },
                                                  ),
                                                  actions: [
                                                    if (isLoading)
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    if (!isLoading)
                                                      TextButton(
                                                          child: Text("No"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                    if (!isLoading)
                                                      TextButton(
                                                          child: Text("Yes"),
                                                          onPressed: () async {
                                                            setState(() {
                                                              isLoading = true;
                                                            });
                                                            await rateEstate(
                                                                widget.id,
                                                                rate.toInt());
                                                            if (context
                                                                .mounted) {
                                                              context
                                                                  .read<
                                                                      EstateBloc>()
                                                                  .add(GetOneEstate(
                                                                      id: widget
                                                                          .id));
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          }),
                                                  ]);
                                            }));
                                  })
                            ],
                          ),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.03),
                          Text("Description",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w600)),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.01),
                          Text(state.estate.description,
                              style: Theme.of(context).textTheme.bodyMedium),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.04),
                          Text("Seller Info",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w600)),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.01),
                          Text("Name: ${state.estate.username}"),
                          Text("Phone: ${state.estate.phone}"),
                          Gap(
                              isHeight: true,
                              isWidth: false,
                              height: height * 0.02),
                          Text("Services",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          context.read<EstateBloc>().services.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                      child: Text("There is no service")))
                              : Column(
                                  children: context
                                      .read<EstateBloc>()
                                      .services
                                      .map((service) => Card(
                                          elevation: 3,
                                          color: Color(0xFFFFFFFF),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(children: [
                                                  CircleAvatar(
                                                      foregroundImage: NetworkImage(
                                                          "https://static.thenounproject.com/png/1389879-200.png"),
                                                      radius: 20),
                                                  SizedBox(width: 20),
                                                  Expanded(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Service: ${service.name}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      18)),
                                                          Text(
                                                              "Price: \$${service.price}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                        ]),
                                                  ),
                                                  TextButton(
                                                      onPressed: () async {
                                                        bool isLoading = false;
                                                        await showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                                  return AlertDialog(
                                                                      title: Text(
                                                                          "Buy ${service.name} service"),
                                                                      content: Text(
                                                                          "Are you sure to buy this service"),
                                                                      actions: [
                                                                        if (isLoading)
                                                                          Center(
                                                                              child: CircularProgressIndicator()),
                                                                        if (!isLoading)
                                                                          TextButton(
                                                                              child: Text("Cancel"),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              }),
                                                                        if (!isLoading)
                                                                          TextButton(
                                                                              child: Text("Buy"),
                                                                              onPressed: () async {
                                                                                setState(() {
                                                                                  isLoading = true;
                                                                                });
                                                                                await buyService(widget.id, service.id);
                                                                                if (context.mounted) {
                                                                                  Navigator.of(context).pop();
                                                                                }
                                                                              }),
                                                                      ]);
                                                                }));
                                                      },
                                                      child: Text("buy"))
                                                ]),
                                              ],
                                            ),
                                          )))
                                      .toList()),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.textPrimary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 14),
                                ),
                                onPressed: () async {
                                  final telUrl = "tel:${widget.sallerPhone}";
                                  if (await canLaunchUrl(Uri.parse(telUrl))) {
                                    await launchUrl(Uri.parse(telUrl));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Could not initiate call")),
                                    );
                                  }
                                },
                                child: Text("Call Seller",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.whiteColor)),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.textPrimary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 14),
                                ),
                                onPressed: () async {
                                  bool isLoading = false;
                                  String comment = "";
                                  await showDialog(
                                      context: context,
                                      builder: (_) => StatefulBuilder(
                                              builder: (context, setState) {
                                            return AlertDialog(
                                                title: Text(
                                                    "Comment on this estate"),
                                                content: TextField(
                                                  maxLines: null,
                                                  decoration: InputDecoration(
                                                    hintText: "write a comment",
                                                  ),
                                                  onChanged: (value) {
                                                    comment = value;
                                                  },
                                                ),
                                                actions: [
                                                  if (isLoading)
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                  if (!isLoading)
                                                    TextButton(
                                                        child: Text("Cancel"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                  if (!isLoading)
                                                    TextButton(
                                                        child: Text("Send"),
                                                        onPressed: () async {
                                                          if (comment == "")
                                                            return;
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          await commentEstate(
                                                              widget.id,
                                                              null,
                                                              comment);
                                                          if (context.mounted) {
                                                            context
                                                                .read<
                                                                    EstateBloc>()
                                                                .add(GetOneEstate(
                                                                    id: widget
                                                                        .id));
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        }),
                                                ]);
                                          }));
                                },
                                child: Text("Add Comment",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppColors.whiteColor)),
                              )
                            ],
                          ),
                          Text("Comments",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          state.estate.comments.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                      child: Text("There is no comment")))
                              : Column(
                                  children: state.estate.comments
                                      .map((comment) => CommentCard(
                                          id: comment["id"],
                                          userId: comment["user_id"],
                                          commentId: comment["comment_id"],
                                          estateId: comment["estate_id"],
                                          comment: comment["comment"],
                                          name: comment["user_name"],
                                          email: comment["email"],
                                          replies: comment["comments"]))
                                      .toList()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      );
    }
  }

  Widget _buildFeature(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

Future<void> rateEstate(int id, int rating) async {
  var headers = {'Authorization': Constant.token!};
  http.Response response = await http.post(
      Uri.parse('${Constant.baseUrl}/estate/rate/$id'),
      body: {'rate': rating.toString()},
      headers: headers);
  print(response.statusCode);
  if (response.statusCode == 200 || response.statusCode == 201) {
    Fluttertoast.showToast(msg: "Rated successfully");
  } else {
    Fluttertoast.showToast(msg: "Unexpected Error");
  }
}

bool isFavorite(int id) {
  for (final json in Constant.favoriteEstates) {
    if (id == json["id"]) return true;
  }

  return false;
}

Future<void> buyService(int estateId, int serviceId) async {
  var headers = {
    'Authorization': Constant.token!,
    "Content-Type": "application/json"
  };
  http.Response response = await http.post(
      Uri.parse('${Constant.baseUrl}/payment'),
      body: jsonEncode({"service_id": serviceId, "estate_id": estateId}),
      headers: headers);
  print(response.statusCode);
  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 204) {
    Fluttertoast.showToast(msg: "Buy successfully");
  } else if (response.statusCode == 402) {
    Fluttertoast.showToast(msg: jsonDecode(response.body)["error"]);
  } else {
    Fluttertoast.showToast(msg: "Unexpected Error");
  }
}
