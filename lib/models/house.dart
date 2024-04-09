class HogwartsHouse {
  final String unix;
  final String date;
  final String symbol;
  final String open;
  final String high;

  HogwartsHouse({
    required this.unix,
    required this.date,
    required this.symbol,
    required this.open,
    required this.high,
  });

  factory HogwartsHouse.fromJson(Map<String, dynamic> json) {
    return HogwartsHouse(
      unix: json['unix'],
      date: json['date'],
      symbol: json['symbol'],
      open: json['open'],
      high: json['high'],
    );
  }
}
