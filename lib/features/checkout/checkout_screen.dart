import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedAddressIndex = 0;
  int _selectedPaymentIndex = 0;
  String _selectedShipping = 'standard';

  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'imageUrl': 'https://picsum.photos/300/300?random=1',
      'title': 'Wireless Bluetooth Headphones',
      'price': 99.99,
      'quantity': 1,
    },
    {
      'id': '2',
      'imageUrl': 'https://picsum.photos/300/300?random=2',
      'title': 'Smart Watch Series 8',
      'price': 299.99,
      'quantity': 1,
    },
  ];

  final List<Map<String, dynamic>> _addresses = [
    {
      'title': 'Home',
      'name': 'John Doe',
      'phone': '+1 (555) 123-4567',
      'address': '123 Main Street, New York, NY 10001',
    },
    {
      'title': 'Office',
      'name': 'John Doe',
      'phone': '+1 (555) 987-6543',
      'address': '456 Business Ave, Suite 100, New York, NY 10002',
    },
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'card',
      'title': 'Credit Card',
      'subtitle': '**** **** **** 1234',
      'icon': HugeIcons.strokeRoundedCreditCard,
    },
    {
      'type': 'paypal',
      'title': 'PayPal',
      'subtitle': 'john.doe@email.com',
      'icon': HugeIcons.strokeRoundedWallet01,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            const SizedBox(height: AppConstants.paddingL),
            _buildShippingAddress(),
            const SizedBox(height: AppConstants.paddingL),
            _buildShippingOptions(),
            const SizedBox(height: AppConstants.paddingL),
            _buildPaymentMethod(),
            const SizedBox(height: AppConstants.paddingL),
            _buildOrderTotal(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        'Checkout',
        style: AppTextStyles.titleLarge,
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Row(
              children: [
                Text(
                  'Order Summary',
                  style: AppTextStyles.titleMedium,
                ),
                const Spacer(),
                Text(
                  '${_cartItems.length} items',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          ..._cartItems.map((item) => _buildOrderItem(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusS),
            child: Image.network(
              item['imageUrl'],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppConstants.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: AppTextStyles.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  'Qty: ${item['quantity']}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${item['price'].toStringAsFixed(2)}',
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingAddress() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedLocation01,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Shipping Address',
                  style: AppTextStyles.titleMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: _showAddressBottomSheet,
                  child: Text(
                    'Change',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingS,
                        vertical: AppConstants.paddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusS),
                      ),
                      child: Text(
                        _addresses[_selectedAddressIndex]['title'],
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingS),
                Text(
                  _addresses[_selectedAddressIndex]['name'],
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  _addresses[_selectedAddressIndex]['phone'],
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  _addresses[_selectedAddressIndex]['address'],
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingOptions() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedTruck,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Shipping Options',
                  style: AppTextStyles.titleMedium,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildShippingOption(
            'standard',
            'Standard Shipping',
            '5-7 business days',
            0.00,
          ),
          _buildShippingOption(
            'express',
            'Express Shipping',
            '2-3 business days',
            9.99,
          ),
          _buildShippingOption(
            'overnight',
            'Overnight Shipping',
            'Next business day',
            19.99,
          ),
        ],
      ),
    );
  }

  Widget _buildShippingOption(String value, String title, String subtitle, double price) {
    final isSelected = _selectedShipping == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedShipping = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.05) : AppColors.white,
          border: isSelected 
              ? Border.all(color: AppColors.primary, width: 1)
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingXS),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price == 0 ? 'FREE' : '\$${price.toStringAsFixed(2)}',
              style: AppTextStyles.titleSmall.copyWith(
                color: price == 0 ? AppColors.success : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedCreditCard,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: AppConstants.paddingS),
                Text(
                  'Payment Method',
                  style: AppTextStyles.titleMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: _showPaymentBottomSheet,
                  child: Text(
                    'Change',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Row(
              children: [
                HugeIcon(
                  icon: _paymentMethods[_selectedPaymentIndex]['icon'],
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _paymentMethods[_selectedPaymentIndex]['title'],
                        style: AppTextStyles.bodyMedium,
                      ),
                      const SizedBox(height: AppConstants.paddingXS),
                      Text(
                        _paymentMethods[_selectedPaymentIndex]['subtitle'],
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTotal() {
    final subtotal = _cartItems.fold<double>(0, (sum, item) => sum + (item['price'] * item['quantity']));
    final shipping = _selectedShipping == 'standard' ? 0.0 : 
                    _selectedShipping == 'express' ? 9.99 : 19.99;
    final tax = subtotal * 0.08; // 8% tax
    final total = subtotal + shipping + tax;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Total',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: AppConstants.paddingM),
            _buildTotalRow('Subtotal', subtotal),
            _buildTotalRow('Shipping', shipping),
            _buildTotalRow('Tax', tax),
            const Divider(height: AppConstants.paddingL, color: AppColors.border),
            Row(
              children: [
                Text(
                  'Total',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingXS),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            amount == 0 ? 'FREE' : '\$${amount.toStringAsFixed(2)}',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        child: ComoButton(
          text: 'Place Order',
          onPressed: _placeOrder,
          isFullWidth: true,
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedCheckmarkCircle01,
            color: AppColors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _showAddressBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Address',
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: AppConstants.paddingL),
            ..._addresses.asMap().entries.map((entry) {
              final index = entry.key;
              final address = entry.value;
              final isSelected = index == _selectedAddressIndex;
              
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedAddressIndex = index;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.paddingM),
                  margin: const EdgeInsets.only(bottom: AppConstants.paddingS),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address['title'],
                              style: AppTextStyles.titleSmall,
                            ),
                            Text(
                              address['name'],
                              style: AppTextStyles.bodyMedium,
                            ),
                            Text(
                              address['address'],
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const HugeIcon(
                          icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                          color: AppColors.primary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showPaymentBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method',
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: AppConstants.paddingL),
            ..._paymentMethods.asMap().entries.map((entry) {
              final index = entry.key;
              final payment = entry.value;
              final isSelected = index == _selectedPaymentIndex;
              
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedPaymentIndex = index;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.paddingM),
                  margin: const EdgeInsets.only(bottom: AppConstants.paddingS),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Row(
                    children: [
                      HugeIcon(
                        icon: payment['icon'],
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: AppConstants.paddingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              payment['title'],
                              style: AppTextStyles.bodyMedium,
                            ),
                            Text(
                              payment['subtitle'],
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const HugeIcon(
                          icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                          color: AppColors.primary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _placeOrder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Order Confirmation',
          style: AppTextStyles.titleMedium,
        ),
        content: Text(
          'Are you sure you want to place this order?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order placed successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: Text(
              'Place Order',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
