import 'package:final_project/config/app_data.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../config/colors.dart';
import 'cart_screen.dart';

class ItemDetailPage extends StatefulWidget {
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int _itemIndex = 0; // Add a variable to store the item index
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 40, bottom: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white30,
                      width: 1.0,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white30,
                      width: 1.0,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _isFavorite
                          ? Colors.red
                          : Colors.white,
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            ),
            Container(
              child: Image.asset(
                'images/item_bird.png',
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Macaw',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Parrot',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.whitecolor,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.whitecolor,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.whitecolor,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.whitecolor,
                      size: 16,
                    ),
                    Icon(
                      Icons.star_half,
                      color: AppColors.whitecolor,
                      size: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        '(4.5)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'Product Description ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Use ReadMoreText instead of LayoutBuilder
                ReadMoreText(
                  'Hi my name is Taha. I am from Lahore. This is a long description that may exceed the maximum number of lines set initially. If it does, the "More" button will be shown to allow the user to expand the text.',
                  trimLines: 3,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'More',
                  trimExpandedText: ' Less',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                  moreStyle: TextStyle(color: Colors.white, fontSize: 15),
                  lessStyle: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    "\$ 3.9/kg",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Text(
                  'Add to cart',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
