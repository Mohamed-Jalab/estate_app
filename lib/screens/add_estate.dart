import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../blocs/estate_bloc/estate_bloc.dart';
import '../constant/constant.dart';

class AddEstate extends StatefulWidget {
  const AddEstate(
      {super.key,
      this.title,
      this.description,
      this.address,
      this.listingType,
      this.imagePath,
      this.estateType,
      this.lat,
      this.lon,
      this.price,
      this.area,
      this.rooms,
      this.id});

  final String? title, description, address, listingType, imagePath, estateType;
  final double? lat, lon;
  final int? id, price, area, rooms;
  @override
  State<AddEstate> createState() => _AddEstateState();
}

class _AddEstateState extends State<AddEstate> {
  bool isLoading = false;

  String? title, description, address, listingType, imagePath, estateType;
  double? lat, lon;
  int? id, price, area, rooms;
  @override
  void initState() {
    super.initState();
    id = widget.id;
    title = widget.title;
    description = widget.description;
    address = widget.address;
    listingType = widget.listingType;
    imagePath = widget.imagePath;
    estateType = widget.estateType;
    lat = widget.lat;
    lon = widget.lon;
    price = widget.price;
    area = widget.area;
    rooms = widget.rooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Estate"), centerTitle: true),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(children: [
                TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: TextEditingController(text: title),
                    onChanged: (value) {
                      title = value;
                    }),
                SizedBox(height: 10),
                TextField(
                    maxLines: 3,
                    decoration: InputDecoration(labelText: "Description"),
                    controller: TextEditingController(text: description),
                    onChanged: (value) {
                      description = value;
                    }),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          keyboardType: TextInputType.number,
                          controller:
                              TextEditingController(text: price?.toString()),
                          decoration: InputDecoration(labelText: "Price"),
                          onChanged: (value) {
                            if (int.tryParse(value) != null)
                              price = int.parse(value);
                          }),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Area"),
                          controller:
                              TextEditingController(text: area?.toString()),
                          onChanged: (value) {
                            if (int.tryParse(value) != null)
                              area = int.parse(value);
                          }),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Rooms"),
                          controller:
                              TextEditingController(text: rooms?.toString()),
                          onChanged: (value) {
                            if (int.tryParse(value) != null)
                              rooms = int.parse(value);
                          }),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(labelText: "Address"),
                          controller: TextEditingController(text: address),
                          onChanged: (value) {
                            address = value;
                          }),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text("Listing Type", style: TextStyle(fontSize: 18)),
                        RadioListTile(
                            value: "rent",
                            title: Text("Rent"),
                            groupValue: listingType,
                            onChanged: (value) {
                              listingType = value;
                              setState(() {});
                            }),
                        SizedBox(height: 2),
                        RadioListTile(
                            value: "sale",
                            title: Text("Sale"),
                            groupValue: listingType,
                            onChanged: (value) {
                              listingType = value;
                              setState(() {});
                            }),
                      ]),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text("Listing Type", style: TextStyle(fontSize: 18)),
                        RadioListTile(
                            value: "land",
                            title: Text("Land"),
                            groupValue: estateType,
                            onChanged: (value) {
                              estateType = value;
                              setState(() {});
                            }),
                        SizedBox(height: 2),
                        RadioListTile(
                            value: "villa",
                            title: Text("Villa"),
                            groupValue: estateType,
                            onChanged: (value) {
                              estateType = value;
                              setState(() {});
                            }),
                        SizedBox(height: 2),
                        RadioListTile(
                            value: "house",
                            title: Text("House"),
                            groupValue: estateType,
                            onChanged: (value) {
                              estateType = value;
                              setState(() {});
                            }),
                        SizedBox(height: 2),
                        RadioListTile(
                            value: "flat",
                            title: Text("Flat"),
                            groupValue: estateType,
                            onChanged: (value) {
                              estateType = value;
                              setState(() {});
                            }),
                        SizedBox(height: 2),
                        RadioListTile(
                            value: "other",
                            title: Text("Other"),
                            groupValue: estateType,
                            onChanged: (value) {
                              estateType = value;
                              setState(() {});
                            }),
                      ]),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: "Latitude"),
                            controller:
                                TextEditingController(text: lat?.toString()),
                            onChanged: (value) {
                              if (double.tryParse(value) != null)
                                lat = double.parse(value);
                            })),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: "Longitude"),
                            controller:
                                TextEditingController(text: lon?.toString()),
                            onChanged: (value) {
                              if (double.tryParse(value) != null)
                                lon = double.parse(value);
                            })),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      XFile? file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        imagePath = file.path;
                      }
                    },
                    child: Text("pick Image")),
                SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () async {
                      if (widget.title == null)
                        await addEstate();
                      else
                        await updateEstate();
                    },
                    child: Text(
                        widget.title == null ? "Add Estate" : "Edit Estate")),
              ]),
            )),
          ),
          if (isLoading)
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.grey.withOpacity(.3),
              child: Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }

  Future<void> addEstate() async {
    if (title == null ||
        description == null ||
        address == null ||
        listingType == null ||
        imagePath == null ||
        price == null ||
        lat == null ||
        lon == null ||
        rooms == null ||
        estateType == null ||
        area == null) {
      Fluttertoast.showToast(msg: "Complete all your fields");
      return;
    }
    setState(() {
      isLoading = true;
    });
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('${Constant.baseUrl}/estate'))
          ..followRedirects = false;

    request.headers['Authorization'] = 'Bearer ${Constant.token!}';
    request.headers['Content-Type'] = 'application/json';

    print({
      'title': title!,
      'description': description!,
      'price': price.toString(),
      'address': address!,
      'area': area.toString(),
      'listing_type': listingType!,
      'location[lat]': lat.toString(),
      'location[lon]': lon.toString(),
      'estate_type': estateType!,
      "other_data[rooms_count]": rooms.toString()
    });
    request.fields.addAll({
      'title': title!,
      'description': description!,
      'price': price.toString(),
      'address': address!,
      'area': area.toString(),
      'listing_type': listingType!,
      'location[lat]': lat.toString(),
      'location[lon]': lon.toString(),
      'estate_type': estateType!,
      "other_data[rooms_count]": rooms.toString()
    });
    request.files.add(await http.MultipartFile.fromPath('image', imagePath!));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isLoading = false;
      setState(() {});
      if (mounted) {
        context.read<EstateBloc>().add(GetAllEstates());
        Navigator.of(context)
          ..pop()
          ..pop();
      }
      Fluttertoast.showToast(msg: "Add it successfully");
    } else {
      print(response.statusCode);
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Error");
    }
  }

  Future<void> updateEstate() async {
    if (lat == null || lon == null || imagePath == null) {
      Fluttertoast.showToast(msg: "Complete all your fields");
      return;
    }
    setState(() {
      isLoading = true;
    });
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('${Constant.baseUrl}/estate/${widget.id}'));

    request.headers.addAll({'Authorization': Constant.token!});

    request.fields.addAll({
      "_method": "PATCH",
      'location[lat]': lat.toString(),
      'location[lon]': lon.toString(),
    });
    request.files.add(await http.MultipartFile.fromPath('image', imagePath!));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isLoading = false;
      setState(() {});
      if (mounted) {
        context.read<EstateBloc>().add(GetAllEstates());
        Navigator.of(context)
          ..pop()
          ..pop();
      }
      Fluttertoast.showToast(msg: "Update it successfully");
    } else {
      print(response.statusCode);
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
