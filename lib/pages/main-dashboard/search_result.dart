import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              iconSize: 20,
              padding: EdgeInsets.zero,
              onPressed: () {},
            ),
          ),
        ),
        title: const Text(
          'Searched Result',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D47A1), // Colors.blue[900]
                Color(0xFF1976D2), // Colors.blue[700]
                Color(0xFF2196F3), // Colors.blue[500]
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 4,
            children: const [
              _ProductCard(
                imageAsset: 'assets/images/IPAD.png',
                name: 'Product 1',
                price: '\$100',
              ),
              _ProductCard(
                imageAsset: 'assets/images/IPAD.png',
                name: 'Product 2',
                price: '\$200',
              ),
              _ProductCard(
                imageAsset: 'assets/images/IPAD.png',
                name: 'Product 3',
                price: '\$150',
              ),
              _ProductCard(
                imageAsset: 'assets/images/IPAD.png',
                name: 'Product 4',
                price: '\$180',
              ),
              _ProductCard(
                imageAsset: 'assets/images/IPAD.png',
                name: 'Product 5',
                price: '\$220',
              ),
              _ProductCard(
                imageAsset: 'assets/images/IPAD.png',
                name: 'Product 6',
                price: '\$190',
              ),
              _ProductCard(
                imageAsset: 'assets/images/IPAD.png',
                name: 'Product 7',
                price: '\$250',
              ),
              _ProductCard(
                imageAsset: 'assets/images/IPAD.png',
                name: 'Product 8',
                price: '\$210',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String imageAsset;
  final String name;
  final String price;

  const _ProductCard({
    required this.imageAsset,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // product name
            Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // price
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
