import 'package:final_project/API/parrots/parrots_model_class.dart';
import 'package:final_project/config/app_data.dart';
import 'package:final_project/utils/app_utils.dart';
import 'package:final_project/widgets/item_card.dart';
import 'package:flutter/material.dart';

class FavoriteItemScreen extends StatefulWidget {
  @override
  _FavoriteItemScreenState createState() => _FavoriteItemScreenState();
}

class _FavoriteItemScreenState extends State<FavoriteItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppUtils.calculateDynamicWidth(context, 0.1),
              vertical: AppUtils.calculateDynamicMargin(context, 0.05),
            ),
            child: Row(
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
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
              childAspectRatio: 0.59,
              children: AppConfig.favoriteItemIds.map((itemId) {
                final Parrot parrot = AppConfig.Parrots.firstWhere((parrot) => parrot.id == itemId);
                return ItemCard(
                  imageUrl: parrot.imageUrl,
                  itemCategory: parrot.category,
                  itemName: parrot.name,
                  itemPrice: parrot.price,
                  isFavorite: true,
                  onFavoriteToggle: () {
                    setState(() {
                      AppConfig.favoriteItemIds.remove(parrot.id);
                    });
                  },
                );
              }).toList(),
            ),

          )
        ],
      ),
    );
  }
}
