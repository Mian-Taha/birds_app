import 'package:flutter/material.dart';

import '../widgets/cart_item.dart';
import '../widgets/total_amount_card.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'My Order',
              style: TextStyle(color: Colors.white),
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 4.0,right: 4,bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white30, // Set the border color to white
                  width: 1.0, // Set the border width
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                color: Colors.white, // Set the icon color to white
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  CartItem(),
                  CartItem(),
                  CartItem(),
                  CartItem(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TotalAmountCard(),
            ),
          ],
        ),
      ),
    );
  }
}
