import 'dart:async';

class MockApiService {
  // Mock earnings data for different time periods
  static const mockEarnings = {
    "today": 1000,
    "this_week": 7424,
    "this_month": 25000,
    "total": 95000,
  };

  // Mock chart data for earnings over the week
  static const mockChartData = [
    {"day": "Mon", "earnings": 100},
    {"day": "Tue", "earnings": 200},
    {"day": "Wed", "earnings": 150},
    {"day": "Thu", "earnings": 400},
    {"day": "Fri", "earnings": 300},
    {"day": "Sat", "earnings": 350},
    {"day": "Sun", "earnings": 600},
  ];

  // Mock summary data
  static const mockSummary = {
    "earned_this_week": 7424,
    "orders_completed": 40,
    "ongoing_orders": 1,
  };

  // Simulate API call to fetch earnings data
  Future<Map<String, dynamic>> getEarnings(String timePeriod) async {
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return {
      "status": "success",
      "data": {
        "total_earnings": mockEarnings["total"],
        "currency": "₹",
        "earnings": {
          "today": mockEarnings["today"],
          "this_week": mockEarnings["this_week"],
          "this_month": mockEarnings["this_month"],
          "total": mockEarnings["total"]
        }
      }
    };
  }

  // Simulate API call to fetch chart data
  Future<Map<String, dynamic>> getChartData(String timePeriod) async {
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return {
      "status": "success",
      "data": {"chart_data": mockChartData}
    };
  }

  // Simulate API call to fetch summary data
  Future<Map<String, dynamic>> getSummary() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return {"status": "success", "data": mockSummary};
  }

  // Simulate API call to fetch date range based on selected time period
  Future<Map<String, dynamic>> getDateRange(String timePeriod) async {
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay
    DateTime today = DateTime.now();
    String formattedRange = '';

    if (timePeriod == 'week') {
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
      formattedRange =
          "${startOfWeek.day} ${_getMonthName(startOfWeek.month)} ${startOfWeek.year} — ${endOfWeek.day} ${_getMonthName(endOfWeek.month)} ${endOfWeek.year}";
    } else if (timePeriod == 'month') {
      DateTime startOfMonth = DateTime(today.year, today.month, 1);
      DateTime endOfMonth = DateTime(today.year, today.month + 1, 0);
      formattedRange =
          "${startOfMonth.day} ${_getMonthName(startOfMonth.month)} ${startOfMonth.year} — ${endOfMonth.day} ${_getMonthName(endOfMonth.month)} ${endOfMonth.year}";
    } else if (timePeriod == 'today') {
      formattedRange =
          "${today.day} ${_getMonthName(today.month)} ${today.year}";
    } else {
      formattedRange = "All Time";
    }

    return {
      "status": "success",
      "data": {"formatted_range": formattedRange}
    };
  }

  // Helper function to get month name
  static String _getMonthName(int month) {
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
}
