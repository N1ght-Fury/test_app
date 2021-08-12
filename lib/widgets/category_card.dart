import 'package:flutter/material.dart';

import 'custom_network_image.dart';

class CategoryCard extends StatelessWidget {
  final Map categoryData;
  final Function() onTap;
  const CategoryCard({required this.categoryData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.7),
                blurRadius: 1.0,
                spreadRadius: 2,
                offset: const Offset(
                  0.0,
                  0.0,
                ),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              child: CustomNetworkImage(
                url: categoryData['picture'],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
