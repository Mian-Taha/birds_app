import 'package:final_project/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final bool isFavorite;
  final String itemName;
  final String itemCategory;
  final double itemPrice;
  final String imageUrl;
  final VoidCallback onFavoriteToggle;

  const ItemCard({
    required this.isFavorite,
    required this.itemName,
    required this.itemCategory,
    required this.itemPrice,
    required this.imageUrl,
    required this.onFavoriteToggle,

  });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ItemDetailPage when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade900,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.imageUrl, // Replace with the imageUrl from your Parrot object
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                        widget.onFavoriteToggle();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.white54,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 8,
                left: 20,
                bottom: 4,
              ),
              child: Text(
                widget.itemName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                bottom: 8,
              ),
              child: Text(
                widget.itemCategory,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                bottom: 10,
              ),
              child: Text(
                "\$${widget.itemPrice.toStringAsFixed(2)}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
