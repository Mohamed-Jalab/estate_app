import 'package:estate2/components/gap.dart';
import 'package:estate2/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/property/property_details_page.dart';

class FeaturedCard extends StatelessWidget {
  final String path, category, title, location, payment;
  final num price, rating;
  const FeaturedCard(
      {super.key,
      required this.path,
      required this.category,
      required this.title,
      required this.rating,
      required this.location,
      required this.price,
      required this.payment});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PropertyDetailsPage(
                  id: 0,
                  title: title,
                  local: true,
                  description:
                      "A minimalist architectural masterpiece with clean lines, floor-to-ceiling windows, and smart home technology.",
                  imageUrl: path,
                  location: location,
                  price: price.toString(),
                  isNetwork: false,
                  area: 600,
                  bedrooms: 3,
                  bathrooms: 2,
                  rating: rating.toDouble(),
                  sallerName: "Ahmad Ali",
                  sallerPhone: "+963-99-999-9999",
                  propertyType: "rent or sale",
                )));
      },
      child: Container(
        height: height / 4,
        width: width / 1.35,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
                height: double.infinity,
                width: 134,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(path), fit: BoxFit.cover)),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: AppColors.textPrimary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          category,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ))),
            Gap(isWidth: true, isHeight: false, width: width * 0.02),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.01),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(rating.toString())
                  ],
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.01),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.textPrimary,
                    ),
                    Text(
                      location,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 12),
                    )
                  ],
                ),
                Gap(isWidth: false, isHeight: true, height: height * 0.03),
                Row(
                  children: [
                    Text(
                      "${format.currencySymbol} $price/",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "month",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
