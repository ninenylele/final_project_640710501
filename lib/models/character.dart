class HarryPotterCharacter {
  final String name;
  final String nickname;
  final String house;
  final String portrayedBy;
  final String relatives;
  final String imageUrl;
  final String birthdate;

  HarryPotterCharacter({
    required this.name,
    required this.nickname,
    required this.house,
    required this.portrayedBy,
    required this.relatives,
    required this.imageUrl,
    required this.birthdate,
  });

  factory HarryPotterCharacter.fromJson(Map<String, dynamic> json) {
    return HarryPotterCharacter(
      name: json['unix'],
      nickname: json['date'],
      house: json['symbol'],
      portrayedBy: json['open'],
      relatives: json['high'],
      imageUrl: json['low'],
      birthdate: json['close'],
    );
  }
}
