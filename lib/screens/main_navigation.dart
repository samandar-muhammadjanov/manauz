import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mana_uz/screens/home_screen.dart';
import 'package:mana_uz/screens/catalog_screen.dart';
import 'package:mana_uz/screens/order_screen.dart';
import 'package:mana_uz/screens/about_screen.dart';
import 'package:mana_uz/constants/app_colors.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  
  // List of screens to display in the bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const CatalogScreen(),
    OrderScreen(
      product: {
        'id': 'default',
        'name': 'Example Product',
        'price': 0,
        'image': 'assets/images/placeholder.png',
        'category': 'default',
        'months': 12,
        'installmentPrice': 0,
      },
    ),
    const AboutScreen(),
  ];
  
  // Bottom navigation items
  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Bosh sahifa',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category_outlined),
      activeIcon: Icon(Icons.category),
      label: 'Katalog',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag),
      label: 'Buyurtma',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info_outline),
      activeIcon: Icon(Icons.info),
      label: 'Biz haqimizda',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Handle page changes with animation
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Handle bottom navigation item tap with animation
  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    
    setState(() {
      _currentIndex = index;
    });
    
    // Animate to the selected page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using PageView for smooth horizontal transitions
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: _screens,
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: _buildAnimatedBottomNavBar(),
    );
  }
  
  // Custom animated bottom navigation bar
  Widget _buildAnimatedBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_bottomNavBarItems.length, (index) {
              final isSelected = _currentIndex == index;
              final item = _bottomNavBarItems[index];
              
              return _buildNavItem(
                icon: isSelected ? item.activeIcon! : item.icon,
                label: item.label!,
                isSelected: isSelected,
                onTap: () => _onItemTapped(index),
              );
            }),
          ),
        ),
      ),
    ).animate().slideY(
      duration: 300.ms,
      begin: 0.5,
      end: 0,
      curve: Curves.easeOutQuad,
    );
  }
  
  // Custom navigation item with animation
  Widget _buildNavItem({
    required Widget icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with animation
            IconTheme(
              data: IconThemeData(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
              child: icon,
            ),
            
            // Label with animation
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
