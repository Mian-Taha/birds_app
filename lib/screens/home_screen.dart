import 'package:final_project/API/parrots/parrots_api_getter.dart';
import 'package:final_project/config/app_data.dart';
import 'package:flutter/material.dart';
import 'package:final_project/API/parrots/parrots_model_class.dart';
import 'package:final_project/screens/favorite_items_Screen.dart';
import 'package:final_project/screens/user_profile_screen.dart';
import '../widgets/item_card.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItemIndex = 0;
  int _bottomNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  late Future<void> _fetchAndStoreParrotsFuture; // Future to fetch and store parrot data
  @override
  void initState() {
    super.initState();
    _fetchAndStoreParrotsFuture = ApiService.fetchParrotInfoList();
  }

  Future<void> fetchData() async {
    try {
      await ApiService.fetchParrotInfoList();

    } catch (e) {
      // Handle error
      print("Error fetching data: $e");
      // You can show an error message to the user if needed
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('Home')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: SearchBar(
                controller: _searchController,
                onTextChanged: (text) {
                  // Handle search text changes here
                },
                onFilterPressed: () {
                  // Handle filter icon press here
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConfig.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedItemIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            AppConfig.items[index],
                            style: TextStyle(
                              color: _selectedItemIndex == index
                                  ? Colors.white
                                  : Colors.white54,
                              fontSize: 18,
                              fontWeight: _selectedItemIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (_selectedItemIndex == index)
                            Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: _fetchAndStoreParrotsFuture, // Use the future here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Loading indicator while data is being fetched
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Display error message if fetching data fails
                    return Text("Error fetching data: ${snapshot.error}");
                  } else {
                    // Display the GridView with data from AppConfig.Parrots
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.56,
                      children: AppConfig.Parrots.map((parrot) {
                        return ItemCard(
                          imageUrl: parrot.imageUrl,
                          itemCategory: parrot.category,
                          itemName: parrot.name,
                          itemPrice: parrot.price,
                          isFavorite: AppConfig.favoriteItemIds.contains(parrot.id),
                          onFavoriteToggle: () {
                            setState(() {
                              if (AppConfig.favoriteItemIds.contains(parrot.id)) {
                                AppConfig.favoriteItemIds.remove(parrot.id);
                              } else {
                                AppConfig.favoriteItemIds.add(parrot.id);
                              }
                            });
                          },
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          onTap: (index) {
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileScreen()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteItemScreen()),
              );
            } else {
              setState(() {
                _bottomNavIndex = index;
              });
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
