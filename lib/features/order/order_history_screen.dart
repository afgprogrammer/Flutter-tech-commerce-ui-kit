import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/como_button.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD-001',
      'date': '2024-01-15',
      'status': 'delivered',
      'total': '\$129.99',
      'items': [
        {
          'imageUrl': 'https://picsum.photos/300/300?random=1',
          'title': 'Wireless Bluetooth Headphones',
          'quantity': 1,
          'price': '\$99.99',
        },
        {
          'imageUrl': 'https://picsum.photos/300/300?random=2',
          'title': 'USB-C Fast Charging Cable',
          'quantity': 1,
          'price': '\$19.99',
        },
      ],
    },
    {
      'id': 'ORD-002',
      'date': '2024-01-10',
      'status': 'shipped',
      'total': '\$299.99',
      'trackingNumber': 'TK123456789',
      'items': [
        {
          'imageUrl': 'https://picsum.photos/300/300?random=3',
          'title': 'Smart Watch Series 8',
          'quantity': 1,
          'price': '\$299.99',
        },
      ],
    },
    {
      'id': 'ORD-003',
      'date': '2024-01-05',
      'status': 'processing',
      'total': '\$159.99',
      'items': [
        {
          'imageUrl': 'https://picsum.photos/300/300?random=4',
          'title': 'Gaming Mechanical Keyboard',
          'quantity': 1,
          'price': '\$129.99',
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(_orders),
                _buildOrdersList(_orders.where((o) => o['status'] == 'processing').toList()),
                _buildOrdersList(_orders.where((o) => o['status'] == 'shipped').toList()),
                _buildOrdersList(_orders.where((o) => o['status'] == 'delivered').toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        'My Orders',
        style: AppTextStyles.titleLarge,
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Handle search orders
          },
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTextStyles.labelMedium,
        unselectedLabelStyle: AppTextStyles.labelMedium,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2,
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Processing'),
          Tab(text: 'Shipped'),
          Tab(text: 'Delivered'),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order);
      },
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
              icon: HugeIcons.strokeRoundedPackage,
              size: 80,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              'No orders found',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'You haven\'t placed any orders yet.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingXL),
            ComoButton(
              text: 'Start Shopping',
              onPressed: () {
                Navigator.pop(context);
              },
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
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
          _buildOrderHeader(order),
          _buildOrderItems(order['items']),
          _buildOrderFooter(order),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(Map<String, dynamic> order) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Order ${order['id']}',
                      style: AppTextStyles.titleSmall,
                    ),
                    const Spacer(),
                    _buildStatusChip(order['status']),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  'Placed on ${order['date']}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (order['trackingNumber'] != null) ...[
                  const SizedBox(height: AppConstants.paddingXS),
                  Text(
                    'Tracking: ${order['trackingNumber']}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    IconData iconData;

    switch (status) {
      case 'processing':
        backgroundColor = AppColors.warning.withOpacity(0.1);
        textColor = AppColors.warning;
        iconData = HugeIcons.strokeRoundedClock01;
        break;
      case 'shipped':
        backgroundColor = AppColors.info.withOpacity(0.1);
        textColor = AppColors.info;
        iconData = HugeIcons.strokeRoundedTruck;
        break;
      case 'delivered':
        backgroundColor = AppColors.success.withOpacity(0.1);
        textColor = AppColors.success;
        iconData = HugeIcons.strokeRoundedCheckmarkCircle01;
        break;
      default:
        backgroundColor = AppColors.textSecondary.withOpacity(0.1);
        textColor = AppColors.textSecondary;
        iconData = HugeIcons.strokeRoundedInformationCircle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingS,
        vertical: AppConstants.paddingXS,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(
            icon: iconData,
            size: 14,
            color: textColor,
          ),
          const SizedBox(width: AppConstants.paddingXS),
          Text(
            status.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems(List<Map<String, dynamic>> items) {
    return Column(
      children: items.map((item) => _buildOrderItem(item)).toList(),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingM,
        vertical: AppConstants.paddingS,
      ),
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
                Row(
                  children: [
                    Text(
                      'Qty: ${item['quantity']}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item['price'],
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderFooter(Map<String, dynamic> order) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Total: ${order['total']}',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primary,
            ),
          ),
          const Spacer(),
          if (order['status'] == 'delivered') ...[
            OutlinedButton(
              onPressed: () {
                _showReorderDialog(order);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
              ),
              child: Text(
                'Reorder',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: AppConstants.paddingS),
          ],
          if (order['status'] == 'shipped') ...[
            OutlinedButton(
              onPressed: () {
                _showTrackingDialog(order);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
              ),
              child: Text(
                'Track',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: AppConstants.paddingS),
          ],
          ElevatedButton(
            onPressed: () {
              _showOrderDetails(order);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
            ),
            child: Text(
              'Details',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      builder: (context) => _buildOrderDetailsSheet(order),
    );
  }

  Widget _buildOrderDetailsSheet(Map<String, dynamic> order) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusL),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Order Details',
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
          _buildDetailRow('Order ID', order['id']),
          _buildDetailRow('Order Date', order['date']),
          _buildDetailRow('Status', order['status']),
          if (order['trackingNumber'] != null)
            _buildDetailRow('Tracking Number', order['trackingNumber']),
          _buildDetailRow('Total Amount', order['total']),
          const SizedBox(height: AppConstants.paddingL),
          Text(
            'Items',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppConstants.paddingM),
          ...order['items'].map<Widget>((item) => _buildOrderItem(item)).toList(),
          const SizedBox(height: AppConstants.paddingL),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingS),
      child: Row(
        children: [
          Text(
            '$label:',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppConstants.paddingS),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  void _showReorderDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Reorder Items',
          style: AppTextStyles.titleMedium,
        ),
        content: Text(
          'Add all items from this order to your cart?',
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Items added to cart'),
                ),
              );
            },
            child: Text(
              'Add to Cart',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTrackingDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Track Package',
          style: AppTextStyles.titleMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tracking Number: ${order['trackingNumber']}',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'Your package is on the way!',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.success,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
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
