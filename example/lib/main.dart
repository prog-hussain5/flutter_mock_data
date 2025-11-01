import 'package:flutter/material.dart';
import 'package:flutter_mock_data/flutter_mock_data.dart';

void main() {
  // Optional: switch to Arabic data
  // MockData.setLocale(MockLocale.ar);
  runApp(const MockDataExampleApp());
}

class MockDataExampleApp extends StatelessWidget {
  const MockDataExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter_mock_data example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mock Users')),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          final name = MockData.fullName();
          final email = MockData.email();
          final avatar = MockData.image(category: "animals");
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(avatar)),
            title: Text(name),
            subtitle: Text(email),
            trailing: Text('\$${MockData.price(min: 9, max: 199)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showProduct(context),
        label: const Text('Random Product'),
        icon: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }

  void _showProduct(BuildContext context) {
    final product = MockData.productName();
    final price = MockData.price(min: 10, max: 500);
    final desc = MockData.description();
    final img = MockData.image(category: 'people', width: 600, height: 400);

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    img,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      width: 96,
                      height: 96,
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$$price',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(desc),
          ],
        ),
      ),
    );
  }
}
