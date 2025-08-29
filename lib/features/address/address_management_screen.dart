import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';
import '../../shared/widgets/como_text_field.dart';

class AddressManagementScreen extends StatefulWidget {
  const AddressManagementScreen({super.key});

  @override
  State<AddressManagementScreen> createState() => _AddressManagementScreenState();
}

class _AddressManagementScreenState extends State<AddressManagementScreen> {
  final List<Map<String, dynamic>> _addresses = [
    {
      'id': '1',
      'title': 'Home',
      'name': 'John Doe',
      'phone': '+1 (555) 123-4567',
      'address': '123 Main Street',
      'city': 'New York',
      'state': 'NY',
      'zipCode': '10001',
      'country': 'United States',
      'isDefault': true,
    },
    {
      'id': '2',
      'title': 'Office',
      'name': 'John Doe',
      'phone': '+1 (555) 987-6543',
      'address': '456 Business Ave, Suite 100',
      'city': 'New York',
      'state': 'NY',
      'zipCode': '10002',
      'country': 'United States',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _addresses.isEmpty 
          ? _buildEmptyState() 
          : _buildAddressList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAddressSheet,
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
        'My Addresses',
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
              icon: HugeIcons.strokeRoundedLocation01,
              size: 80,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              'No addresses saved',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'Add your shipping addresses for faster checkout.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingXL),
            ComoButton(
              text: 'Add Address',
              onPressed: _showAddAddressSheet,
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

  Widget _buildAddressList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: _addresses.length,
      itemBuilder: (context, index) {
        final address = _addresses[index];
        return _buildAddressCard(address, index);
      },
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: address['isDefault'] 
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HugeIcon(
                        icon: address['title'] == 'Home' 
                            ? HugeIcons.strokeRoundedHome09
                            : HugeIcons.strokeRoundedBuilding01,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppConstants.paddingXS),
                      Text(
                        address['title'],
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (address['isDefault']) ...[
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
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) => _handleAddressAction(value, index),
                  itemBuilder: (context) => [
                    if (!address['isDefault'])
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
            const SizedBox(height: AppConstants.paddingM),
            Text(
              address['name'],
              style: AppTextStyles.titleSmall,
            ),
            const SizedBox(height: AppConstants.paddingXS),
            Text(
              address['phone'],
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              address['address'],
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppConstants.paddingXS),
            Text(
              '${address['city']}, ${address['state']} ${address['zipCode']}',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppConstants.paddingXS),
            Text(
              address['country'],
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddressAction(String action, int index) {
    switch (action) {
      case 'default':
        _setAsDefault(index);
        break;
      case 'edit':
        _showEditAddressSheet(_addresses[index]);
        break;
      case 'delete':
        _showDeleteDialog(index);
        break;
    }
  }

  void _setAsDefault(int index) {
    setState(() {
      for (int i = 0; i < _addresses.length; i++) {
        _addresses[i]['isDefault'] = i == index;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Default address updated'),
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Address',
          style: AppTextStyles.titleMedium,
        ),
        content: Text(
          'Are you sure you want to delete this address?',
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
                _addresses.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address deleted'),
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

  void _showAddAddressSheet() {
    _showAddressSheet(null);
  }

  void _showEditAddressSheet(Map<String, dynamic> address) {
    _showAddressSheet(address);
  }

  void _showAddressSheet(Map<String, dynamic>? address) {
    final isEdit = address != null;
    final titleController = TextEditingController(text: address?['title'] ?? '');
    final nameController = TextEditingController(text: address?['name'] ?? '');
    final phoneController = TextEditingController(text: address?['phone'] ?? '');
    final addressController = TextEditingController(text: address?['address'] ?? '');
    final cityController = TextEditingController(text: address?['city'] ?? '');
    final stateController = TextEditingController(text: address?['state'] ?? '');
    final zipCodeController = TextEditingController(text: address?['zipCode'] ?? '');
    final countryController = TextEditingController(text: address?['country'] ?? 'United States');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      builder: (context) => Padding(
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
                    isEdit ? 'Edit Address' : 'Add New Address',
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
                controller: titleController,
                label: 'Address Title',
                hint: 'e.g., Home, Office',
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedTag01,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(height: AppConstants.paddingM),
              ComoTextField(
                controller: nameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(height: AppConstants.paddingM),
              ComoTextField(
                controller: phoneController,
                label: 'Phone Number',
                hint: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCall,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(height: AppConstants.paddingM),
              ComoTextField(
                controller: addressController,
                label: 'Street Address',
                hint: 'Enter your street address',
                maxLines: 2,
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedLocation01,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(height: AppConstants.paddingM),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ComoTextField(
                      controller: cityController,
                      label: 'City',
                      hint: 'Enter city',
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingM),
                  Expanded(
                    child: ComoTextField(
                      controller: stateController,
                      label: 'State',
                      hint: 'State',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingM),
              Row(
                children: [
                  Expanded(
                    child: ComoTextField(
                      controller: zipCodeController,
                      label: 'ZIP Code',
                      hint: 'ZIP Code',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingM),
                  Expanded(
                    flex: 2,
                    child: ComoTextField(
                      controller: countryController,
                      label: 'Country',
                      hint: 'Enter country',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingL),
              ComoButton(
                text: isEdit ? 'Update Address' : 'Save Address',
                onPressed: () {
                  _saveAddress(
                    address,
                    titleController.text,
                    nameController.text,
                    phoneController.text,
                    addressController.text,
                    cityController.text,
                    stateController.text,
                    zipCodeController.text,
                    countryController.text,
                  );
                  Navigator.pop(context);
                },
                isFullWidth: true,
              ),
              const SizedBox(height: AppConstants.paddingM),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAddress(
    Map<String, dynamic>? existingAddress,
    String title,
    String name,
    String phone,
    String address,
    String city,
    String state,
    String zipCode,
    String country,
  ) {
    final newAddress = {
      'id': existingAddress?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'isDefault': existingAddress?['isDefault'] ?? _addresses.isEmpty,
    };

    setState(() {
      if (existingAddress != null) {
        final index = _addresses.indexWhere((a) => a['id'] == existingAddress['id']);
        if (index != -1) {
          _addresses[index] = newAddress;
        }
      } else {
        _addresses.add(newAddress);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(existingAddress != null ? 'Address updated' : 'Address added'),
      ),
    );
  }
}
