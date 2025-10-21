import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome03,
              color: AppColors.textSecondary,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome03,
              color: AppColors.primary,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: AppColors.textSecondary,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: AppColors.primary,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingCart01,
              color: AppColors.textSecondary,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingCart01,
              color: AppColors.primary,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              color: AppColors.textSecondary,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              color: AppColors.primary,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
