import 'package:flutter/material.dart';
import 'package:rechoice_app/components/admin/admin_shared_widget.dart';
import 'package:rechoice_app/models/services/dashboard_service.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late final DashboardService _dashboardService;
  late Future<DashboardMetrics> _metricsFuture;

  @override
  void initState() {
    super.initState();
    _dashboardService = DashboardService();
    _metricsFuture = _dashboardService.getDashboardMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return AdminSliverScaffold(
      selectedTabIndex: 0,
      title: 'Dashboard Overview',
      subtitle: 'Monitor your platform performance and key metrics',
      body: FutureBuilder<DashboardMetrics>(
        future: _metricsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error loading dashboard: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _metricsFuture = _dashboardService.getDashboardMetrics();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final metrics = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Stats Cards Grid
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Total Users',
                          value: metrics.totalUsers.toString(),
                          change: 'All registered users',
                          changeColor: Colors.green,
                          icon: Icons.person,
                          iconColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _StatCard(
                          title: 'Active Users',
                          value: metrics.activeUsers.toString(),
                          change: '${((metrics.activeUsers / (metrics.totalUsers > 0 ? metrics.totalUsers : 1)) * 100).toStringAsFixed(1)}% active',
                          changeColor: Colors.green,
                          icon: Icons.check_circle,
                          iconColor: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Total Listings',
                          value: metrics.totalListings.toString(),
                          change: 'Items on platform',
                          changeColor: Colors.green,
                          icon: Icons.shopping_bag,
                          iconColor: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _StatCard(
                          title: 'Pending Reports',
                          value: metrics.pendingReports.toString(),
                          change: metrics.pendingReports > 0 ? '⚠️ Needs review' : '✅ All clear',
                          changeColor: metrics.pendingReports > 0 ? Colors.red : Colors.green,
                          icon: Icons.warning,
                          iconColor: metrics.pendingReports > 0 ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Recent Activity Section
                  const Text(
                    'Recent Activity',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Activity Cards
                  if (metrics.recentActivity.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'No recent activity',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: metrics.recentActivity.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final activity = metrics.recentActivity[index];
                        final iconData = _getActivityIcon(activity.iconType);

                        return _ActivityCard(
                          icon: iconData,
                          iconColor: _getActivityColor(activity.type),
                          title: activity.title,
                          subtitle: activity.subtitle,
                          time: activity.timeAgo,
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getActivityIcon(String iconType) {
    switch (iconType) {
      case 'user':
        return Icons.person_add;
      case 'listing':
        return Icons.shopping_bag;
      case 'report':
        return Icons.warning;
      case 'message':
        return Icons.message;
      default:
        return Icons.info;
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'user_registration':
        return Colors.blue;
      case 'listing_created':
        return Colors.orange;
      case 'listing_approved':
        return Colors.green;
      case 'report_filed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final Color changeColor;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.changeColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            change,
            style: TextStyle(
              fontSize: 13,
              color: changeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Activity Card Widget
class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String time;

  const _ActivityCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Time
          Text(time, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
        ],
      ),
    );
  }
}
