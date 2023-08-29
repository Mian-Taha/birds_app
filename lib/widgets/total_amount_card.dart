import 'package:flutter/material.dart';

class TotalAmountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildRow('Subtotal', '\$19.99',16),
          _buildRow('Delivery Fee', '\$15.99',16),
          _buildRow('Tax', '\$9.99',16),
          _buildSeparator(),
          _buildRow('Total', '\$5.99',20),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement place order logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade800,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 90),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            child: Text(
              'Place Order',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String amount, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 1,
      color: Colors.black,
    );
  }
}
