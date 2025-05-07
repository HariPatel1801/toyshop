import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1. Product Model
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String ageRange;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.ageRange,
    required this.rating,
    required this.reviewCount,
  });
}

// 2. Category Model
class Category {
  final String id;
  final String name;
  final String imageUrl;
  final List<Product> products;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.products,
  });
}

// 3. Cart Item Model
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

// 4. State Management
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const ToyShopApp(),
    ),
  );
}

class ToyShopApp extends StatelessWidget {
  const ToyShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toy Shop',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 6. Home Screen with Categories
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Category> categories = [
    Category(
      id: 'cat1',
      name: 'Building Toys',
      imageUrl: 'Category_Images/building_toys.jpg',
      products: [
        Product(
          id: 'prod1',
          name: 'Building Blocks Set',
          price: 19.99,
          imageUrl: 'Category_Images/building_toys.jpg',
          description: 'Creative blocks for kids.',
          ageRange: '3-8 years',
          rating: 4.5,
          reviewCount: 100,
        ),
        Product(
          id: 'prod2',
          name: 'Mega Construction Kit',
          price: 29.99,
          imageUrl: 'Category_Images/building_toys.jpg',
          description: 'Mega construction set for big ideas.',
          ageRange: '5-12 years',
          rating: 4.7,
          reviewCount: 200,
        ),
      ],
    ),
    Category(
      id: 'cat2',
      name: 'Dolls & Playsets',
      imageUrl: 'Category_Images/dolls.jpg',
      products: [
        Product(
          id: 'prod3',
          name: 'Princess Doll',
          price: 24.99,
          imageUrl: 'Category_Images/dolls.jpg',
          description: 'Beautiful princess doll for imaginative play.',
          ageRange: '3-6 years',
          rating: 4.8,
          reviewCount: 300,
        ),
        Product(
          id: 'prod4',
          name: 'Barbie Dream Set',
          price: 39.99,
          imageUrl: 'Category_Images/dolls.jpg',
          description: 'Barbie and her dream accessories.',
          ageRange: '5-10 years',
          rating: 4.6,
          reviewCount: 250,
        ),
      ],
    ),
    Category(
      id: 'cat3',
      name: 'Vehicles',
      imageUrl: 'Category_Images/vehicle.jpg',
      products: [
        Product(
          id: 'prod5',
          name: 'Remote Control Car',
          price: 34.99,
          imageUrl: 'Category_Images/vehicle.jpg',
          description: 'Fast RC car with LED lights.',
          ageRange: '6-12 years',
          rating: 4.3,
          reviewCount: 180,
        ),
        Product(
          id: 'prod6',
          name: 'Monster Truck Toy',
          price: 27.99,
          imageUrl: 'Category_Images/vehicle.jpg',
          description: 'Monster truck with big wheels.',
          ageRange: '5-10 years',
          rating: 4.4,
          reviewCount: 150,
        ),
      ],
    ),
    Category(
      id: 'cat4',
      name: 'Puzzles',
      imageUrl: 'Category_Images/puzzle.jpg',
      products: [
        Product(
          id: 'prod7',
          name: 'Animal Puzzle',
          price: 14.99,
          imageUrl: 'Category_Images/puzzle.jpg',
          description: 'Wooden animal puzzle with 60 pieces.',
          ageRange: '3-5 years',
          rating: 4.6,
          reviewCount: 120,
        ),
        Product(
          id: 'prod8',
          name: 'World Map Puzzle',
          price: 19.99,
          imageUrl: 'Category_Images/puzzle.jpg',
          description: 'Educational world map puzzle.',
          ageRange: '6-10 years',
          rating: 4.7,
          reviewCount: 180,
        ),
      ],
    ),
    Category(
      id: 'cat5',
      name: 'Outdoor',
      imageUrl: 'Assets/Category_Images/outdoor.jpg',
      products: [
        Product(
          id: 'prod9',
          name: 'Inflatable Bounce House',
          price: 149.99,
          imageUrl: 'Assets/Category_Images/outdoor.jpg',
          description: 'Large bounce house for backyard fun.',
          ageRange: '3-10 years',
          rating: 4.4,
          reviewCount: 90,
        ),
        Product(
          id: 'prod10',
          name: 'Kids Trampoline',
          price: 199.99,
          imageUrl: 'Assets/Category_Images/outdoor.jpg',
          description: 'Safe trampoline with net enclosure.',
          ageRange: '5-12 years',
          rating: 4.5,
          reviewCount: 75,
        ),
      ],
    ),
    Category(
      id: 'cat6',
      name: 'Learning',
      imageUrl: 'Category_Images/learning.jpg',
      products: [
        Product(
          id: 'prod11',
          name: 'STEM Robotics Kit',
          price: 49.99,
          imageUrl: 'Category_Images/learning.jpg',
          description: 'Build and program 5 robot models.',
          ageRange: '8-14 years',
          rating: 4.7,
          reviewCount: 200,
        ),
        Product(
          id: 'prod12',
          name: 'Math Learning Board',
          price: 19.99,
          imageUrl: 'Category_Images/learning.jpg',
          description: 'Wooden math learning board for kids.',
          ageRange: '4-8 years',
          rating: 4.6,
          reviewCount: 170,
        ),
      ],
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // softer background
      appBar: AppBar(
        title: const Text('Toy Shop'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Badge(
              label: Consumer<CartProvider>(
                builder: (context, cart, child) =>
                    Text(cart.totalItems.toString()),
              ),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  const Text(
                    'Search for toys...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              'Welcome to the Toy Shop!\nFind the best toys for every child!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250, // max width per card
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 7. Category Card Widget

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CategoryScreen(category: category)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  category.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 8. Category Screen
class CategoryScreen extends StatelessWidget {
  final Category category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: category.products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: category.products[index]);
        },
      ),
    );
  }
}

// 9. Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(product.description),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                final cartItem = cart.items.firstWhere(
                      (item) => item.product.id == product.id,
                  orElse: () => CartItem(product: product, quantity: 0),
                );
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'In Cart: ${cartItem.quantity}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: cartItem.quantity > 0
                              ? () => cart.removeFromCart(product.id)
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => cart.addToCart(product),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 10. Cart Screen
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: cart.items.isEmpty
                    ? const Center(child: Text('Your cart is empty'))
                    : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Image.asset(
                          item.product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.product.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '\$${item.product.price.toStringAsFixed(2)}'),
                            Text('Quantity: ${item.quantity}'),
                            Text(
                                'Total: \$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              cart.removeFromCart(item.product.id),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 18)),
                        Text(
                          '\$${cart.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: cart.items.isEmpty
                          ? null
                          : () {
                        cart.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Order placed successfully!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
