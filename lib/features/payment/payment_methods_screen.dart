import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';
import '../../shared/widgets/como_text_field.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': '1',
      'type': 'visa',
      'title': 'Visa **** 1234',
      'subtitle': 'Expires 12/26',
      'isDefault': true,
      'icon': HugeIcons.strokeRoundedCreditCard,
    },
    {
      'id': '2',
      'type': 'mastercard',
      'title': 'Mastercard **** 5678',
      'subtitle': 'Expires 08/27',
      'isDefault': false,
      'icon': HugeIcons.strokeRoundedCreditCard,
    },
    {
      'id': '3',
      'type': 'paypal',
      'title': 'PayPal',
      'subtitle': 'john.doe@email.com',
      'isDefault': false,
      'icon': HugeIcons.strokeRoundedWallet01,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _paymentMethods.isEmpty 
          ? _buildEmptyState() 
          : _buildPaymentMethodsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPaymentMethodSheet,
        backgroundColor: AppColors.primary,
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedAdd01,
          color: AppColors.white,
          size: 24,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        'Payment Methods',
        style: AppTextStyles.titleLarge,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HugeIcon(
              icon: HugeIcons.strokeRoundedCreditCard,
              size: 80,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              'No payment methods',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'Add your payment methods for secure and fast checkout.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingXL),
            ComoButton(
              text: 'Add Payment Method',
              onPressed: _showAddPaymentMethodSheet,
              isFullWidth: true,
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedAdd01,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: _paymentMethods.length,
      itemBuilder: (context, index) {
        final paymentMethod = _paymentMethods[index];
        return _buildPaymentMethodCard(paymentMethod, index);
      },
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> paymentMethod, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: paymentMethod['isDefault'] 
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingS),
              decoration: BoxDecoration(
                color: _getCardColor(paymentMethod['type']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: HugeIcon(
                icon: paymentMethod['icon'],
                color: _getCardColor(paymentMethod['type']),
                size: 24,
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        paymentMethod['title'],
                        style: AppTextStyles.titleSmall,
                      ),
                      if (paymentMethod['isDefault']) ...[
                        const SizedBox(width: AppConstants.paddingS),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingS,
                            vertical: AppConstants.paddingXS,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppConstants.radiusS),
                          ),
                          child: Text(
                            'DEFAULT',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingXS),
                  Text(
                    paymentMethod['subtitle'],
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) => _handlePaymentMethodAction(value, index),
              itemBuilder: (context) => [
                if (!paymentMethod['isDefault'])
                  const PopupMenuItem(
                    value: 'default',
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: AppConstants.paddingS),
                        Text('Set as Default'),
                      ],
                    ),
                  ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedEdit02,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: AppConstants.paddingS),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedDelete02,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      SizedBox(width: AppConstants.paddingS),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedMoreVertical,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCardColor(String type) {
    switch (type) {
      case 'visa':
        return const Color(0xFF1434CB);
      case 'mastercard':
        return const Color(0xFFEB001B);
      case 'paypal':
        return const Color(0xFF003087);
      default:
        return AppColors.primary;
    }
  }

  void _handlePaymentMethodAction(String action, int index) {
    switch (action) {
      case 'default':
        _setAsDefault(index);
        break;
      case 'edit':
        _showEditPaymentMethodSheet(_paymentMethods[index]);
        break;
      case 'delete':
        _showDeleteDialog(index);
        break;
    }
  }

  void _setAsDefault(int index) {
    setState(() {
      for (int i = 0; i < _paymentMethods.length; i++) {
        _paymentMethods[i]['isDefault'] = i == index;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Default payment method updated'),
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Payment Method',
          style: AppTextStyles.titleMedium,
        ),
        content: Text(
          'Are you sure you want to delete this payment method?',
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
              setState(() {
                _paymentMethods.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment method deleted'),
                ),
              );
            },
            child: Text(
              'Delete',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPaymentMethodSheet() {
    _showPaymentMethodSheet(null);
  }

  void _showEditPaymentMethodSheet(Map<String, dynamic> paymentMethod) {
    _showPaymentMethodSheet(paymentMethod);
  }

  void _showPaymentMethodSheet(Map<String, dynamic>? paymentMethod) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      builder: (context) => _buildPaymentMethodForm(paymentMethod),
    );
  }

  Widget _buildPaymentMethodForm(Map<String, dynamic>? paymentMethod) {
    final isEdit = paymentMethod != null;
    final cardNumberController = TextEditingController();
    final cardHolderController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: AppConstants.paddingL,
        right: AppConstants.paddingL,
        top: AppConstants.paddingL,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppConstants.paddingL,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  isEdit ? 'Edit Payment Method' : 'Add Payment Method',
                  style: AppTextStyles.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedCancel01,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingL),
            ComoTextField(
              controller: cardNumberController,
              label: 'Card Number',
              hint: '1234 5678 9012 3456',
              keyboardType: TextInputType.number,
              prefixIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedCreditCard,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            ComoTextField(
              controller: cardHolderController,
              label: 'Cardholder Name',
              hint: 'John Doe',
              prefixIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Row(
              children: [
                Expanded(
                  child: ComoTextField(
                    controller: expiryController,
                    label: 'Expiry Date',
                    hint: 'MM/YY',
                    keyboardType: TextInputType.number,
                    prefixIcon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedCalendar03,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.paddingM),
                Expanded(
                  child: ComoTextField(
                    controller: cvvController,
                    label: 'CVV',
                    hint: '123',
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    prefixIcon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedLockPassword,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingL),
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedShield01,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: AppConstants.paddingS),
                  Expanded(
                    child: Text(
                      'Your payment information is encrypted and secure',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.paddingL),
            ComoButton(
              text: isEdit ? 'Update Payment Method' : 'Add Payment Method',
              onPressed: () {
                _savePaymentMethod(
                  paymentMethod,
                  cardNumberController.text,
                  cardHolderController.text,
                  expiryController.text,
                  cvvController.text,
                );
                Navigator.pop(context);
              },
              isFullWidth: true,
            ),
            const SizedBox(height: AppConstants.paddingM),
          ],
        ),
      ),
    );
  }

  void _savePaymentMethod(
    Map<String, dynamic>? existingMethod,
    String cardNumber,
    String cardHolder,
    String expiry,
    String cvv,
  ) {
    // In a real app, you would validate and process the payment method
    final newMethod = {
      'id': existingMethod?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      'type': _getCardType(cardNumber),
      'title': '${_getCardType(cardNumber).toUpperCase()} **** ${cardNumber.substring(cardNumber.length - 4)}',
      'subtitle': 'Expires $expiry',
      'isDefault': existingMethod?['isDefault'] ?? _paymentMethods.isEmpty,
      'icon': HugeIcons.strokeRoundedCreditCard,
    };

    setState(() {
      if (existingMethod != null) {
        final index = _paymentMethods.indexWhere((m) => m['id'] == existingMethod['id']);
        if (index != -1) {
          _paymentMethods[index] = newMethod;
        }
      } else {
        _paymentMethods.add(newMethod);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(existingMethod != null ? 'Payment method updated' : 'Payment method added'),
      ),
    );
  }

  String _getCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) return 'visa';
    if (cardNumber.startsWith('5')) return 'mastercard';
    return 'card';
  }
}
