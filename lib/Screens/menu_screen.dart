import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  final List<Map<String, dynamic>> foodItems = const [
    {
      'name': 'Burger',
      'price': '\$5.99',
      'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png',
    },
    {
      'name': 'Pizza',
      'price': '\$8.99',
      'image': 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png',
    },
    {
      'name': 'Pasta',
      'price': '\$6.49',
      'image': 'https://cdn-icons-png.flaticon.com/512/135/135620.png',
    },
    {
      'name': 'Sushi',
      'price': '\$12.99',
      'image': 'https://cdn-icons-png.flaticon.com/512/1046/1046791.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: false,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile')),
              );
            },
        
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: foodItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final item = foodItems[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Image.network(
                    item['image'],
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item['price'],
                    style: const TextStyle(color: Colors.green),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${item['name']} to cart!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Icon(Icons.shopping_cart, color: const Color.fromARGB(255, 108, 100, 100)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
