import '../screens/add_recipe_screen.dart';
import '../screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'drawer.dart';
import 'grocery_screen.dart';
import 'recipe_with_pie_chart.dart';
import 'package:sensors/sensors.dart';

class ShakeToNavigate extends StatefulWidget {
  @override
  _ShakeToNavigateState createState() => _ShakeToNavigateState();
}

class _ShakeToNavigateState extends State<ShakeToNavigate> {
  bool _isShaking = false;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x.abs() > 20 || event.y.abs() > 20 || event.z.abs() > 20) {
        if (!_isShaking) {
          setState(() {
            _isShaking = true;
          });
          // Navigate to another screen
          if (_selectedPageIndex < 4) {
            setState(() {
              _selectedPageIndex++;
            });
          } else {
            setState(() {
              _selectedPageIndex = 0;
            });
          }
          // Wait for a moment before allowing another shake
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _isShaking = false;
            });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Stop listening to accelerometer events
    accelerometerEvents.drain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: _selectedPageIndex == 0
          ? AppBar(
              title: Text(
                'Recipes',
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: IconThemeData(color: Colors.black),
            )
          : null,
      body: [
        MyFlipCard(),
        ChatScreen(),
        CreateRecipeScreen(),
        GroceryScreen(),
        NavScreen(),
      ][_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor:
            Color.fromARGB(221, 42, 40, 40), // changed to white for contrast
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed, // changed to fixed type
        // fixedColor: Colors.amber, // removed this line
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            activeIcon: Icon(
              Icons.local_dining,
            ),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_sharp),
            activeIcon: Icon(
              Icons.book,
            ),
            label: 'Recipe Sage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(
              Icons.add_circle,
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            activeIcon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            activeIcon: Icon(
              Icons.play_circle_filled,
            ),
            label: 'Youtube',
          ),
        ],
      ),
      // Adding the ThemeData for this screen
    );
  }
}
