class UserData {
  final String id;
  final String name;
  final String email;
  final String mobileNo;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
  });

  // A factory constructor to parse JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
    );
  }
}
