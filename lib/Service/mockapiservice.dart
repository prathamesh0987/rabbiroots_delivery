class MockApiService {
  Future<Map<String, dynamic>> getEarnings(String timePeriod) async {
    // Simulate a network request to your backend
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    // Depending on the timePeriod, fetch appropriate data
    if (timePeriod == "today") {
      return _getTodayData();
    } else if (timePeriod == "week") {
      return _getThisWeekData();
    } else if (timePeriod == "month") {
      return _getThisMonthData();
    } else {
      return _getTotalData();
    }
  }

  Future<Map<String, dynamic>> getChartData(String timePeriod) async {
    // Simulate a network request to your backend
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    if (timePeriod == "today") {
      return _getTodayChartData();
    } else if (timePeriod == "week") {
      return _getThisWeekChartData();
    } else if (timePeriod == "month") {
      return _getThisMonthChartData();
    } else {
      return _getTotalChartData();
    }
  }

  Future<Map<String, dynamic>> getSummary() async {
    // Simulate a network request to your backend
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return {
      "data": {
        "earned_this_week": 1200,
        "orders_completed": 50,
        "ongoing_orders": 5,
      }
    };
  }

  Future<Map<String, dynamic>> getDateRange(String timePeriod) async {
    // Simulate fetching date range from backend
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return {
      "data": {"formatted_range": _getFormattedRange(timePeriod)}
    };
  }

  // Mock data for different time periods
  Map<String, dynamic> _getTodayData() {
    return {
      "data": {
        "earnings": 200,
      }
    };
  }

  Map<String, dynamic> _getThisWeekData() {
    return {
      "data": {
        "earnings": 1200,
      }
    };
  }

  Map<String, dynamic> _getThisMonthData() {
    return {
      "data": {
        "earnings": 4800,
      }
    };
  }

  Map<String, dynamic> _getTotalData() {
    return {
      "data": {
        "earnings": 24000,
      }
    };
  }

  // Mock chart data for different time periods
  Map<String, dynamic> _getTodayChartData() {
    return {
      "data": {
        "chart_data": [
          {"hour": "6 AM", "earnings": 10},
          {"hour": "12 PM", "earnings": 30},
          {"hour": "6 PM", "earnings": 50},
        ]
      }
    };
  }

  Map<String, dynamic> _getThisWeekChartData() {
    return {
      "data": {
        "chart_data": [
          {"day": "Mon", "earnings": 150},
          {"day": "Tue", "earnings": 200},
          {"day": "Wed", "earnings": 180},
          {"day": "Thu", "earnings": 220},
          {"day": "Fri", "earnings": 190},
          {"day": "Sat", "earnings": 210},
          {"day": "Sun", "earnings": 250},
        ]
      }
    };
  }

  Map<String, dynamic> _getThisMonthChartData() {
    return {
      "data": {
        "chart_data": [
          {"day": "1", "earnings": 50},
          {"day": "2", "earnings": 100},
          {"day": "3", "earnings": 150},
          // Add more data for each day of the month
        ]
      }
    };
  }

  Map<String, dynamic> _getTotalChartData() {
    return {
      "data": {
        "chart_data": [
          {"month": "January", "earnings": 500},
          {"month": "February", "earnings": 600},
          {"month": "March", "earnings": 700},
        ]
      }
    };
  }

  String _getFormattedRange(String timePeriod) {
    if (timePeriod == "today") {
      return "Today";
    } else if (timePeriod == "week") {
      return "This Week";
    } else if (timePeriod == "month") {
      return "This Month";
    } else {
      return "Total Earnings";
    }
  }
}
