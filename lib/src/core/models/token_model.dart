class TokenModel {
  final String uid;
  final String deviceToken;

  TokenModel({required this.uid, required this.deviceToken});

  factory TokenModel.fromMap(Map<String, dynamic> map) => TokenModel(
        uid: map['uid'],
        deviceToken: map['deviceToken'],
      );

  Map<String, dynamic> toMap() => {'uid': uid, 'deviceToken': deviceToken};
}
