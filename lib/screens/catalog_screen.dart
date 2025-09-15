import 'package:flutter/material.dart';
import 'package:mana_uz/constants/app_colors.dart';
import 'package:mana_uz/constants/app_constants.dart';
import 'package:mana_uz/widgets/product_card.dart';
import 'package:mana_uz/widgets/section_header.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedSort = 'popular';
  final List<Map<String, dynamic>> _sortOptions = [
    {'id': 'popular', 'label': 'Mashhurlik bo\'yicha'},
    {'id': 'price_asc', 'label': 'Arzon narxdan'},
    {'id': 'price_desc', 'label': 'Qimmat narxdan'},
    {'id': 'newest', 'label': 'Yangi kelganlar'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: true,
                title: const Text('Katalog'),
                bottom: TabBar(
                  dividerHeight: 0,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Telefonlar',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                          color: _tabController.index == 0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Noutbuklar',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                          color: _tabController.index == 1
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    insets: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  splashFactory: NoSplash.splashFactory,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: _showFilterBottomSheet,
                  ),
                ],
              ),
            ];
          },
          body: Column(
            children: [
              // Filter and Sort Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Sort Dropdown
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedSort,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.textSecondary,
                          ),
                          items: _sortOptions.map((option) {
                            return DropdownMenuItem<String>(
                              value: option['id'],
                              child: Text(
                                option['label'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedSort = value;
                                // TODO: Apply sorting
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Products Grid
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildProductsGrid('phones'),
                    _buildProductsGrid('laptops'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid(String category) {
    // Filter products by category
    final products = AppConstants.featuredProducts
        .where((product) => product['category'] == category)
        .toList();

    if (products.isEmpty) {
      return const Center(child: Text('Mahsulotlar topilmadi'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () {
            // Navigate to product details
          },
        );
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filtrlar',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Price Range
              const Text(
                'Narx oralig\'i',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              // Price range slider would go here
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0 so\'m',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  Text(
                    '50,000,000+ so\'m',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Brands
              const Text(
                'Brendlar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              // Brand checkboxes would go here
              _buildBrandFilter(),

              const Spacer(),

              // Apply Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filters
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Natijalarni ko\'rish'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBrandFilter() {
    final brands = [
      {'id': 'apple', 'name': 'Apple', 'count': 24},
      {'id': 'samsung', 'name': 'Samsung', 'count': 18},
      {'id': 'xiaomi', 'name': 'Xiaomi', 'count': 15},
      {'id': 'hp', 'name': 'HP', 'count': 10},
      {'id': 'lenovo', 'name': 'Lenovo', 'count': 8},
    ];

    return Column(
      children: brands.map((brand) {
        return CheckboxListTile(
          value: false, // This would be controlled by state
          onChanged: (value) {
            // Update brand filter
          },
          title: Text('${brand['name']} (${brand['count']})'),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
          activeColor: AppColors.primary,
        );
      }).toList(),
    );
  }
}
