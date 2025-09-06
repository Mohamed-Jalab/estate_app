import 'package:flutter/material.dart';
import 'package:estate2/components/home/property_card.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  double maxPrice = 500000;
  String selectedLocation = 'All';
  bool isGrid = true;

  final List<Map<String, dynamic>> properties = [
    {
      'title': 'Luxury Villa',
      'location': 'California',
      'image': 'lib/assets/images/property1.jpg',
      'price': '\$450,000',
      'description': 'A beautiful villa in California with sea view.',
    },
    {
      'title': 'Modern Apartment',
      'location': 'New York',
      'image': 'lib/assets/images/property2.jpg',
      'price': '\$300,000',
      'description': 'A stylish apartment in downtown New York.',
    },
    {
      'title': 'Cozy Cottage',
      'location': 'Texas',
      'image': 'lib/assets/images/property2.jpg',
      'price': '\$150,000',
      'description': 'A warm and cozy home in the heart of Texas.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProperties = properties.where((property) {
      final price = double.tryParse(
              property['price'].toString().replaceAll(RegExp(r'[^\d.]'), '')) ??
          0;
      final locationMatch =
          selectedLocation == 'All' || property['location'] == selectedLocation;
      return price <= maxPrice && locationMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Properties'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Price Filter Slider
            Row(
              children: [
                const Text("Max Price: "),
                Expanded(
                  child: Slider(
                    value: maxPrice,
                    min: 50000,
                    max: 1000000,
                    divisions: 20,
                    label: '\$${maxPrice.round()}',
                    onChanged: (value) {
                      setState(() {
                        maxPrice = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Location Dropdown
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
                  items:
                      ['All', 'New York', 'California', 'Texas', 'Washington']
                          .map(
                            (location) => DropdownMenuItem(
                              value: location,
                              child: Text(location),
                            ),
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
            const SizedBox(height: 12),
            // View Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Grid View"),
                Switch(
                  value: isGrid,
                  onChanged: (value) {
                    setState(() {
                      isGrid = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Property List
            Expanded(
              child: isGrid
                  ? GridView.builder(
                      itemCount: filteredProperties.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final property = filteredProperties[index];
                        return PropertyCard(
                          id: index,
                          title: property['title'],
                          location: property['location'],
                          rating: 4.5,
                          area: 100,
                          imageUrl: property['image'],
                          price: property['price'],
                          description: property['description'],
                          listingType: property['listing_type'],
                          isBig: false,
                          isNetwork: false,
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: filteredProperties.length,
                      itemBuilder: (context, index) {
                        final property = filteredProperties[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: PropertyCard(
                            id: index,
                            title: property['title'],
                            location: property['location'],
                            rating: 4.5,
                            area: 100,
                            imageUrl: property['image'],
                            price: property['price'],
                            description: property['description'],
                            listingType: property['listing_type'],
                            isBig: true,
                            isNetwork: false,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
