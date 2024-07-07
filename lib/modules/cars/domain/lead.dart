import 'dart:convert';

class Lead {
  int leadId;
  int carId;
  String userName;
  String userEmail;
  Lead({
    required this.leadId,
    required this.carId,
    required this.userName,
    required this.userEmail,
  });

  Lead copyWith({
    int? leadId,
    int? carId,
    String? userName,
    String? userEmail,
  }) {
    return Lead(
      leadId: leadId ?? this.leadId,
      carId: carId ?? this.carId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'leadId': leadId});
    result.addAll({'carId': carId});
    result.addAll({'userName': userName});
    result.addAll({'userEmail': userEmail});

    return result;
  }

  factory Lead.fromMap(Map<String, dynamic> map) {
    return Lead(
      leadId: map['leadId']?.toInt() ?? 0,
      carId: map['carId']?.toInt() ?? 0,
      userName: map['userName'] ?? '',
      userEmail: map['userEmail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Lead.fromJson(String source) => Lead.fromMap(json.decode(source));

  factory Lead.fromDatabase(Map<String, dynamic> map) => Lead(
        leadId: map['leadId']?.toInt() ?? 0,
        carId: map['carId']?.toInt() ?? 0,
        userName: map['userName'] ?? '',
        userEmail: map['userEmail'] ?? '',
      );

  @override
  String toString() {
    return 'Lead(leadId: $leadId, carId: $carId, userName: $userName, userEmail: $userEmail)';
  }
}
