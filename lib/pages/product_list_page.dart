import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String selectedCategory = "All";
  String searchQuery = "";

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    final products = [
      Product(
        id: '1',
        name: 'Lenovo LOQ 15',
        price: 15000000,
        category: 'Electronics',
        emoji: '💻',
        description: 'Laptop gaming performa tinggi',
      ),
      Product(
        id: '2',
        name: 'Iphone 13 Pro',
        price: 8000000,
        category: 'Electronics',
        emoji: '📱',
        description: 'Smartphone flagship terbaru',
      ),
      Product(
        id: '3',
        name: 'Sennheiser HD490',
        price: 1500000,
        category: 'Accessories',
        emoji: '🎧',
        description: 'Headphones noise-cancelling',
      ),
      Product(
        id: '4',
        name: 'Xiaomi Watch 5 Lite',
        price: 3000000,
        category: 'Accessories',
        emoji: '⌚',
        description: 'Smartwatch dengan health tracking',
      ),
      Product(
        id: '5',
        name: 'Canon DSLR',
        price: 12000000,
        category: 'Camera',
        emoji: '📷',
        description: 'Kamera DSLR profesional',
      ),
      Product(
        id: '6',
        name: 'Ipad Air Gen 11',
        price: 7000000,
        category: 'Electronics',
        emoji: '📟',
        description:
            'Tablet dengan ukuran 11inch yang dapat meningkatkan produktivitas',
      ),
      Product(
        id: '7',
        name: 'Aula F75',
        price: 1200000,
        category: 'Gadget',
        emoji: '⌨️',
        description: 'Keyboard mechanical RGB premium',
      ),
      Product(
        id: '8',
        name: 'Razer Viper Pro',
        price: 750000,
        category: 'Peripherals',
        emoji: '🖱️',
        description: 'Mouse gaming presisi tinggi',
      ),
      Product(
        id: '9',
        name: 'LQ 55C4',
        price: 5500000,
        category: 'Gadget',
        emoji: '🖥️',
        description: 'Monitor 4K Ultra HD',
      ),
      Product(
        id: '10',
        name: 'Jbl Flip 6',
        price: 950000,
        category: 'Gadget',
        emoji: '🔊',
        description: 'Speaker portable high bass',
      ),
      Product(
        id: '11',
        name: 'Secret Lab Special Edition',
        price: 2500000,
        category: 'Furniture',
        emoji: '🪑',
        description: 'Kursi gaming ergonomis premium',
      ),
      Product(
        id: '12',
        name: 'External SSD 1TB',
        price: 1800000,
        category: 'Storage',
        emoji: '💾',
        description: 'SSD external kecepatan tinggi',
      ),
      Product(
        id: '13',
        name: 'Action Camera',
        price: 3200000,
        category: 'Camera',
        emoji: '🎥',
        description: 'Kamera aksi waterproof 4K',
      ),
      Product(
        id: '14',
        name: 'Wireless Earbuds',
        price: 850000,
        category: 'Accessories',
        emoji: '🎶',
        description: 'Earbuds bluetooth noise isolation',
      ),
      Product(
        id: '15',
        name: 'Huawei Matepad',
        price: 2100000,
        category: 'Gadget',
        emoji: '🖊️',
        description: 'Tablet gambar digital untuk desain',
      ),
      Product(
        id: '16',
        name: 'RapaTech Power Bank 20000mAh',
        price: 450000,
        category: 'Accessories',
        emoji: '🔋',
        description: 'Power bank fast charging',
      ),
    ];

    final categories = [
      "All",
      "Electronics",
      "Accessories",
      "Camera",
      "Gadget",
      "Peripherals",
      "Furniture",
      "Storage",
    ];

    final filteredProducts = products.where((product) {
      final matchesCategory =
          selectedCategory == "All" || product.category == selectedCategory;

      final matchesSearch = product.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      return matchesCategory && matchesSearch;
    }).toList();

    final cart = Provider.of<CartModel>(context);

    final showCategory =
        _searchFocusNode.hasFocus ||
        searchQuery.isNotEmpty ||
        selectedCategory != "All";

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                ),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cart.itemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: "Search product...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),

              if (showCategory) ...[
                const SizedBox(height: 15),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],

              const SizedBox(height: 15),

              Expanded(
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

                    return Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                product.emoji,
                                style: const TextStyle(fontSize: 60),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  product.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(rupiah.format(product.price)),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<CartModel>().addItem(
                                        product,
                                      );

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${product.name} ditambahkan',
                                          ),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    child: const Text("Add"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
