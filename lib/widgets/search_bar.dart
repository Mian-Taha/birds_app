import 'package:flutter/material.dart';

import '../config/colors.dart';

class SearchBar extends StatelessWidget {
  //Color myColor = Color(0xFF585B58);
  final TextEditingController controller;
  final Function(String)? onTextChanged;
  final Function()? onFilterPressed;

  SearchBar({
    required this.controller,
    this.onTextChanged,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        color: Colors.grey.shade900, // Dark grey background color
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onTextChanged,
                style: TextStyle(color: Colors.white), // Set the text color to white
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 14),
                  hintText: 'Search Product',
                  hintStyle: TextStyle(color: AppColors.textColor, fontSize: 18), // Set the hint text color to white
                  prefixIcon: Container(
                    child: Image.asset(
                      'images/loupe.png', // Replace with the path to your custom search icon image
                      color: Colors.white54,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: onFilterPressed,
              child: Image.asset(
                'images/filter.png', // Replace with the path to your custom filter icon image
                color: AppColors.textColor,
                  width: 55, // Set the desired width of the image
                  height: 25
              ),
            ),
          ],
        ),
      ),
    );
  }
}
