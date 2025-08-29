import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'type': 'order',
      'title': 'Order Delivered',
      'message': 'Your order #ORD-001 has been delivered successfully',
      'time': '2 hours ago',
      'isRead': false,
      'icon': HugeIcons.strokeRoundedPackageDelivered,
      'color': AppColors.success,
    },
    {
      'id': '2',
      'type': 'promotion',
      'title': 'Flash Sale Started!',
      'message': 'Up to 70% off on electronics. Limited time offer!',
      'time': '4 hours ago',
      'isRead': false,
      'icon': HugeIcons.strokeRoundedDiscount,
      'color': AppColors.secondary,
    },
    {
      'id': '3',
      'type': 'order',
      'title': 'Order Shipped',
      'message': 'Your order #ORD-002 is on its way. Track your package.',
      'time': '1 day ago',
      'isRead': true,
      'icon': HugeIcons.strokeRoundedTruck,
      'color': AppColors.info,
    },
    {
      'id': '4',
      'type': 'general',
      'title': 'Welcome to Como!',
      'message': 'Thank you for joining Como. Enjoy shopping with us!',
      'time': '2 days ago',
      'isRead': true,
      'icon': HugeIcons.strokeRoundedGift,
      'color': AppColors.primary,
    },
    {
      'id': '5',
      'type': 'promotion',
      'title': 'New Arrivals',
      'message': 'Check out the latest products in fashion category',
      'time': '3 days ago',
      'isRead': true,
      'icon': HugeIcons.strokeRoundedNewReleases,
      'color': AppColors.accent,
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
                _buildNotificationsList(_notifications),
                _buildNotificationsList(_notifications.where((n) => n['type'] == 'order').toList()),
                _buildNotificationsList(_notifications.where((n) => n['type'] == 'promotion').toList()),
                _buildNotificationsList(_notifications.where((n) => n['type'] == 'general').toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    final unreadCount = _notifications.where((n) => !n['isRead']).length;
    
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        'Notifications',
        style: AppTextStyles.titleLarge,
      ),
      actions: [
        if (unreadCount > 0)
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              'Mark all read',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        PopupMenuButton<String>(
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'settings',
              child: Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedSettings02,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: AppConstants.paddingS),
                  Text('Notification Settings'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'clear',
              child: Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedDelete02,
                    size: 16,
                    color: AppColors.secondary,
                  ),
                  SizedBox(width: AppConstants.paddingS),
                  Text('Clear All'),
                ],
              ),
            ),
          ],
          child: const Padding(
            padding: EdgeInsets.all(AppConstants.paddingS),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedMoreVertical,
              color: AppColors.textSecondary,
              size: 20,
            ),
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
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('All'),
                const SizedBox(width: AppConstants.paddingXS),
                if (_notifications.where((n) => !n['isRead']).isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_notifications.where((n) => !n['isRead']).length}',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Tab(text: 'Orders'),
          const Tab(text: 'Promotions'),
          const Tab(text: 'General'),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
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
              icon: HugeIcons.strokeRoundedNotification03,
              size: 80,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              'No notifications',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.paddingM),
            Text(
              'You\'re all caught up! Check back later for updates.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Dismissible(
      key: Key(notification['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppConstants.paddingL),
        margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedDelete02,
          color: AppColors.white,
          size: 24,
        ),
      ),
      onDismissed: (direction) {
        _deleteNotification(notification['id']);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.paddingM),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: notification['isRead'] 
              ? null 
              : Border.all(color: AppColors.primary.withOpacity(0.3), width: 1),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => _markAsRead(notification['id']),
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.paddingS),
                  decoration: BoxDecoration(
                    color: notification['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: HugeIcon(
                    icon: notification['icon'],
                    color: notification['color'],
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'],
                              style: AppTextStyles.titleSmall.copyWith(
                                fontWeight: notification['isRead'] 
                                    ? FontWeight.normal 
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          if (!notification['isRead'])
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.paddingXS),
                      Text(
                        notification['message'],
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.paddingS),
                      Row(
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedClock01,
                            color: AppColors.textSecondary,
                            size: 14,
                          ),
                          const SizedBox(width: AppConstants.paddingXS),
                          Text(
                            notification['time'],
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) => _handleNotificationAction(value, notification['id']),
                  itemBuilder: (context) => [
                    if (!notification['isRead'])
                      const PopupMenuItem(
                        value: 'read',
                        child: Row(
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: AppConstants.paddingS),
                            Text('Mark as Read'),
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
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'settings':
        _showNotificationSettings();
        break;
      case 'clear':
        _showClearAllDialog();
        break;
    }
  }

  void _handleNotificationAction(String action, String notificationId) {
    switch (action) {
      case 'read':
        _markAsRead(notificationId);
        break;
      case 'delete':
        _deleteNotification(notificationId);
        break;
    }
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final index = _notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        _notifications[index]['isRead'] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
      ),
    );
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      _notifications.removeWhere((n) => n['id'] == notificationId);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification deleted'),
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear All Notifications',
          style: AppTextStyles.titleMedium,
        ),
        content: Text(
          'Are you sure you want to clear all notifications? This action cannot be undone.',
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
                _notifications.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications cleared'),
                ),
              );
            },
            child: Text(
              'Clear All',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
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
            Row(
              children: [
                Text(
                  'Notification Settings',
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
            _buildSettingTile('Order Updates', 'Get notified about order status changes', true),
            _buildSettingTile('Promotions & Offers', 'Receive notifications about sales and offers', true),
            _buildSettingTile('New Products', 'Get notified about new arrivals', false),
            _buildSettingTile('Price Drops', 'Receive alerts when prices drop on wishlisted items', true),
            const SizedBox(height: AppConstants.paddingL),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(String title, String subtitle, bool initialValue) {
    return SwitchListTile(
      title: Text(
        title,
        style: AppTextStyles.bodyMedium,
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      value: initialValue,
      onChanged: (value) {
        // Handle setting change
      },
      activeColor: AppColors.primary,
      contentPadding: EdgeInsets.zero,
    );
  }
}
