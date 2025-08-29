import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> _cartItems = List.from(_sampleCartItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: AppTextStyles.titleLarge,
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          if (_cartItems.isNotEmpty)
            TextButton(
              onPressed: _clearCart,
              child: Text(
                'Clear All',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
        ],
      ),
      body: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar: _cartItems.isNotEmpty ? _buildCheckoutSection() : null,
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingCart01,
              size: 120,
              color: AppColors.grey400,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              'Your cart is empty',
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'Looks like you haven\'t added anything to your cart yet',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingXL),
            ComoButton(
              text: 'Start Shopping',
              isFullWidth: true,
              onPressed: () {
                // Navigate to home or shop
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              return _buildCartItem(_cartItems[index], index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                child: Image.network(
                  item['image'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const HugeIcon(
                      icon: HugeIcons.strokeRoundedImage01,
                      color: AppColors.textSecondary,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: AppTextStyles.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.paddingXS),
                  Text(
                    item['price'] as String,
                    style: AppTextStyles.productPrice.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Row(
                    children: [
                      _buildQuantityControls(item, index),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _removeItem(index),
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedDelete02,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls(Map<String, dynamic> item, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => _decreaseQuantity(index),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedRemove01,
              size: 18,
              color: AppColors.textPrimary,
            ),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingS),
            child: Text(
              item['quantity'].toString(),
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () => _increaseQuantity(index),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedAdd01,
              size: 18,
              color: AppColors.textPrimary,
            ),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    final subtotal = _calculateSubtotal();
    final shipping = 9.99;
    final total = subtotal + shipping;

    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: AppTextStyles.bodyMedium,
                ),
                Text(
                  '\$${subtotal.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: AppTextStyles.bodyMedium,
                ),
                Text(
                  '\$${shipping.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            const Divider(height: AppConstants.paddingL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingM),
            ComoButton(
              text: 'Proceed to Checkout',
              isFullWidth: true,
              onPressed: _proceedToCheckout,
            ),
          ],
        ),
      ),
    );
  }

  void _increaseQuantity(int index) {
    setState(() {
      _cartItems[index]['quantity']++;
    });
  }

  void _decreaseQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      setState(() {
        _cartItems[index]['quantity']--;
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cartItems.clear();
              });
              Navigator.pop(context);
            },
            child: Text(
              'Clear All',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _proceedToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CheckoutScreen(),
      ),
    );
  }

  double _calculateSubtotal() {
    double subtotal = 0;
    for (var item in _cartItems) {
      double price = double.parse((item['price'] as String).replaceAll('\$', ''));
      int quantity = item['quantity'] as int;
      subtotal += price * quantity;
    }
    return subtotal;
  }
}

// Sample cart items
final List<Map<String, dynamic>> _sampleCartItems = [
  {
    'image': AppConstants.placeholderImage,
    'title': 'Wireless Bluetooth Headphones',
    'price': '\$99.99',
    'quantity': 1,
  },
  {
    'image': AppConstants.placeholderImage,
    'title': 'Smart Watch Series 6',
    'price': '\$299.99',
    'quantity': 1,
  },
  {
    'image': AppConstants.placeholderImage,
    'title': 'Premium Coffee Maker',
    'price': '\$199.99',
    'quantity': 2,
  },
];
