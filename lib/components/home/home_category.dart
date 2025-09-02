import 'package:flutter/material.dart';
import 'package:estate2/constant/colors.dart';

class HomeCategory extends StatefulWidget {
  final String title;
  final void Function() onTap;
  final bool active;

  const HomeCategory(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.active})
      : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: width / 4,
        decoration: BoxDecoration(
            color: widget.active
                ? AppColors.textPrimary
                : AppColors.inputBackground,
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(widget.title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: widget.active
                      ? AppColors.whiteColor
                      : AppColors.textPrimary)),
        ),
      ),
    );
  }
}
