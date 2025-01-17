import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyEarningsScreen extends StatefulWidget {
  @override
  _MyEarningsScreenState createState() => _MyEarningsScreenState();
}

class _MyEarningsScreenState extends State<MyEarningsScreen> {
  int selectedTab = 1; // 0: Today, 1: This Week, 2: This Month, 3: Total

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Earnings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabBar(),
              SizedBox(height: 24),
              _buildDateRange(),
              SizedBox(height: 24),
              _buildChart(),
              SizedBox(height: 20),
              _buildSummary(),
            ],
          ),
        ),
      ),
    );
  }

  // Tab Bar
  Widget _buildTabBar() {
    return Card(
      color: Color(0xff056839),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _tabItem("Today", 0),
                _tabItem("This Week", 1),
                _tabItem("This Month", 2),
                _tabItem("Total", 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selectedTab == index ? Colors.orange : Color(0xff056839),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Date Range Selector
  Widget _buildDateRange() {
    String dateRange = _getDateRangeForTab();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back_ios, size: 16, color: Colors.black),
          Text(
            dateRange,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
        ],
      ),
    );
  }

  // Get Date Range based on the selected tab
  String _getDateRangeForTab() {
    DateTime today = DateTime.now();
    String dateRange = '';

    if (selectedTab == 0) {
      // Today
      dateRange = "${today.day} ${_getMonthName(today.month)} ${today.year}";
    } else if (selectedTab == 1) {
      // This Week
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
      dateRange =
          "${startOfWeek.day} ${_getMonthName(startOfWeek.month)} ${startOfWeek.year} — ${endOfWeek.day} ${_getMonthName(endOfWeek.month)} ${endOfWeek.year}";
    } else if (selectedTab == 2) {
      // This Month
      DateTime startOfMonth = DateTime(today.year, today.month, 1);
      DateTime endOfMonth = DateTime(today.year, today.month + 1, 0);
      dateRange =
          "${startOfMonth.day} ${_getMonthName(startOfMonth.month)} ${startOfMonth.year} — ${endOfMonth.day} ${_getMonthName(endOfMonth.month)} ${endOfMonth.year}";
    } else if (selectedTab == 3) {
      // Total
      dateRange = "All Time";
    }

    return dateRange;
  }

  // Helper function to get month name
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }

  // Chart Section
  Widget _buildChart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 100,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Text("Mon");
                        case 1:
                          return Text("Tue");
                        case 2:
                          return Text("Wed");
                        case 3:
                          return Text("Thu");
                        case 4:
                          return Text("Fri");
                        case 5:
                          return Text("Sat");
                        case 6:
                          return Text("Sun");
                        default:
                          return Text("");
                      }
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 100),
                    FlSpot(1, 200),
                    FlSpot(2, 150),
                    FlSpot(3, 400),
                    FlSpot(4, 300),
                    FlSpot(5, 350),
                    FlSpot(6, 600),
                  ],
                  isCurved: true,
                  barWidth: 4,
                  color: Colors.orange,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.orange.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Summary Section
  Widget _buildSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const Text(
            "Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start, // Centers the text horizontally
          ),
          Row(
            children: [
              // Each card here is wrapped with Flexible for equal width distribution
              Flexible(
                child: _buildSummaryCard(
                  title: "Earned this week",
                  value: "₹7424",
                  color: Color(0xff056839),
                  icon: Icons.monetization_on,
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                child: _buildSummaryCard(
                  title: "Orders Completed",
                  value: "40",
                  color: Colors.orange,
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Single card in this case, no need for Flexible
          _buildSummaryCard(
            title: "Ongoing Orders",
            value: "1",
            color: Color(0xff439617),
            icon: Icons.arrow_forward,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Icon(icon, color: Colors.white, size: 40),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Bar
}
