class UserRegistrationData {
  String email;
  String referralCode;
  String country;
  String state;
  String city;
  String district;
  String longitude;
  String latitude;
  String phoneNumber;

  UserRegistrationData({
    required this.email,
    required this.referralCode,
    required this.country,
    required this.state,
    required this.city,
    required this.district,
    required this.longitude,
    required this.latitude,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'referralCode': referralCode,
    'country': country,
    'state': state,
    'city': city,
    'district': district,
    'longitude': longitude,
    'latitude': latitude,
    'phoneNumber': phoneNumber,
  };

  factory UserRegistrationData.fromJson(Map<String, dynamic> json) => UserRegistrationData(
    email: json['email'],
    referralCode: json['referralCode'],
    country: json['country'],
    state: json['state'],
    city: json['city'],
    district: json['district'],
    longitude: json['longitude'],
    latitude: json['latitude'],
    phoneNumber: json['phoneNumber'],
  );
}
