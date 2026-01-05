import 'package:flutter/material.dart';
import 'package:rechoice_app/components/admin/admin_shared_widget.dart';

class ReportAnalyticsPage extends StatefulWidget {
  const ReportAnalyticsPage({super.key});

  @override
  State<ReportAnalyticsPage> createState() => _ReportAnalyticsPageState();
}

class _ReportAnalyticsPageState extends State<ReportAnalyticsPage> {
  int selectedTabIndex = 3; // Reports & Analytics tab selected

  @override
  Widget build(BuildContext context) {
    return AdminSliverScaffold(
      selectedTabIndex: 3,
      title: 'Reports & Analytics',
      subtitle: 'Monitor reports and generate analytics',

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Report Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Report Summary',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Total Reports
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Reports',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Text(
                          '89',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Resolved
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Resolved',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Text(
                          '67',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Pending
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pending',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Text(
                          '22',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Report Types Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Report Types',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _ReportTypeRow(
                      title: 'Fraud Reports',
                      count: '34',
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    _ReportTypeRow(
                      title: 'Inappropriate Content',
                      count: '28',
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    _ReportTypeRow(
                      title: 'Seller Issues',
                      count: '18',
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    _ReportTypeRow(
                      title: 'Product Quality',
                      count: '9',
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Stats Grid
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Avg Resolution Time',
                      value: '2.3 days',
                      icon: Icons.timer,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      title: 'Resolution Rate',
                      value: '75.3%',
                      icon: Icons.trending_up,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Active Reports',
                      value: '22',
                      icon: Icons.warning,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      title: 'This Month',
                      value: '31',
                      icon: Icons.calendar_month,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Top Reported Products Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top Reported Products',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _TopReportedProductTile(
                      rank: 1,
                      productName: 'iPhone 15 Pro Max',
                      seller: 'TechStore123',
                      reports: 8,
                      reason: 'Fraud/Counterfeit',
                    ),
                    const SizedBox(height: 16),
                    _TopReportedProductTile(
                      rank: 2,
                      productName: 'Designer Handbag Replica',
                      seller: 'LuxuryDeals',
                      reports: 6,
                      reason: 'Counterfeit Product',
                    ),
                    const SizedBox(height: 16),
                    _TopReportedProductTile(
                      rank: 3,
                      productName: 'Gaming Laptop RTX4090',
                      seller: 'ElectroHub',
                      reports: 5,
                      reason: 'Quality Issues',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Weekly Trends Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weekly Report Trends',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TrendBarItem(day: 'Mon', count: 8, maxCount: 15),
                        _TrendBarItem(day: 'Tue', count: 12, maxCount: 15),
                        _TrendBarItem(day: 'Wed', count: 10, maxCount: 15),
                        _TrendBarItem(day: 'Thu', count: 15, maxCount: 15),
                        _TrendBarItem(day: 'Fri', count: 9, maxCount: 15),
                        _TrendBarItem(day: 'Sat', count: 6, maxCount: 15),
                        _TrendBarItem(day: 'Sun', count: 4, maxCount: 15),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _TrendMetric(label: 'Peak Day', value: 'Thursday', subtext: '15 reports'),
                        _TrendMetric(label: 'Lowest', value: 'Sunday', subtext: '4 reports'),
                        _TrendMetric(label: 'Avg/Day', value: '9.1', subtext: 'reports'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Top Reporters Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Most Active Reporters',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _ActiveReporterTile(
                      rank: 1,
                      name: 'Ahmad Hassan',
                      reports: 12,
                      helpfulRating: 94,
                    ),
                    const SizedBox(height: 16),
                    _ActiveReporterTile(
                      rank: 2,
                      name: 'Sarah Johnson',
                      reports: 9,
                      helpfulRating: 88,
                    ),
                    const SizedBox(height: 16),
                    _ActiveReporterTile(
                      rank: 3,
                      name: 'John Doe',
                      reports: 7,
                      helpfulRating: 85,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // User Satisfaction Metrics
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Satisfaction & Feedback',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _SatisfactionMetric(
                            label: 'Overall Satisfaction',
                            percentage: 82,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _SatisfactionMetric(
                            label: 'Resolution Quality',
                            percentage: 78,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _SatisfactionMetric(
                            label: 'Response Time',
                            percentage: 71,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _SatisfactionMetric(
                            label: 'Communication',
                            percentage: 85,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Recent Reports Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Reports',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _RecentReportTile(
                      reportId: 'REP-2026-0089',
                      subject: 'Fraudulent Listing - iPhone 15',
                      reporter: 'Ahmad Hassan',
                      status: 'Pending',
                      statusColor: Colors.orange,
                      date: '2 hours ago',
                    ),
                    const Divider(height: 20),
                    _RecentReportTile(
                      reportId: 'REP-2026-0088',
                      subject: 'Inappropriate Content in Product Description',
                      reporter: 'Sarah Johnson',
                      status: 'Resolved',
                      statusColor: Colors.green,
                      date: '1 day ago',
                    ),
                    const Divider(height: 20),
                    _RecentReportTile(
                      reportId: 'REP-2026-0087',
                      subject: 'Seller Not Delivering Items',
                      reporter: 'John Doe',
                      status: 'In Review',
                      statusColor: Colors.blue,
                      date: '3 days ago',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Report Type Row Widget
class _ReportTypeRow extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const _ReportTypeRow({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            count,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Recent Report Tile Widget
class _RecentReportTile extends StatelessWidget {
  final String reportId;
  final String subject;
  final String reporter;
  final String status;
  final Color statusColor;
  final String date;

  const _RecentReportTile({
    required this.reportId,
    required this.subject,
    required this.reporter,
    required this.status,
    required this.statusColor,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reportId,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subject,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reported by: $reporter',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Top Reported Product Tile Widget
class _TopReportedProductTile extends StatelessWidget {
  final int rank;
  final String productName;
  final String seller;
  final int reports;
  final String reason;

  const _TopReportedProductTile({
    required this.rank,
    required this.productName,
    required this.seller,
    required this.reports,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: rank == 1 ? Colors.amber : rank == 2 ? Colors.grey[400] : Colors.orange[300],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Seller: $seller',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    reason,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Reports Count
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$reports',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'reports',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Trend Bar Item Widget
class _TrendBarItem extends StatelessWidget {
  final String day;
  final int count;
  final int maxCount;

  const _TrendBarItem({
    required this.day,
    required this.count,
    required this.maxCount,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = count / maxCount;
    return Column(
      children: [
        Container(
          width: 30,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 30,
                height: 120 * percentage,
                decoration: BoxDecoration(
                  color: count > 12 ? Colors.red : Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        Text(
          '$count',
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}

// Trend Metric Widget
class _TrendMetric extends StatelessWidget {
  final String label;
  final String value;
  final String subtext;

  const _TrendMetric({
    required this.label,
    required this.value,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtext,
          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
        ),
      ],
    );
  }
}

// Active Reporter Tile Widget
class _ActiveReporterTile extends StatelessWidget {
  final int rank;
  final String name;
  final int reports;
  final int helpfulRating;

  const _ActiveReporterTile({
    required this.rank,
    required this.name,
    required this.reports,
    required this.helpfulRating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Rank Badge
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              '$rank',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Reporter Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.flag, size: 14, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    'Helpful Rating: $helpfulRating%',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Reports Count
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                '$reports',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                'reports',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue[300],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Satisfaction Metric Widget
class _SatisfactionMetric extends StatelessWidget {
  final String label;
  final int percentage;
  final Color color;

  const _SatisfactionMetric({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
