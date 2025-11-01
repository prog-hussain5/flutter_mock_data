import 'package:flutter/material.dart';
import 'package:flutter_mock_data/flutter_mock_data.dart';

void main() {
  // Optional: switch to Arabic data
  MockData.setLocale(MockLocale.en);
  runApp(const MockDataExampleApp());
}

class MockDataExampleApp extends StatelessWidget {
  const MockDataExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      appBar: AppBar(title: const Text('Mock Products (Grid)')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            final name = MockData.productName();
            final desc = MockData.description(sentences: 1);
            // جرّب فئات صور متعددة لعرض تنوّع الشبكة
            final categories = [
              'tech', 'fashion', 'food', 'animals', 'travel', 'nature',
              'cars', 'coffee', 'music', 'art', 'business', 'sports'
            ];
            final img = MockData.image(
              category: categories[index % categories.length],
              width: 600,
              height: 600,
            );
            final price = MockData.price(min: 9, max: 299);

            return Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => _showProduct(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Square image on top
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        img,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => Container(
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image_outlined),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            desc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${price.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              FilledButton.icon(
                                onPressed: () => _showProduct(context),
                                icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
                                label: const Text('Add'),
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity.compact,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showProduct(BuildContext context) {
    final product = MockData.productName();
    final price = MockData.price(min: 10, max: 500);
    final desc = MockData.description();
    final img = MockData.image(category: 'tech', width: 600, height: 400);

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
                      Text(product, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6),
                      Text('\$$price', style: Theme.of(context).textTheme.titleLarge),
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