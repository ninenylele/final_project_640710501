class Book {
  final String unix;
  final String date;
  final String symbol;
  final String open;
  final String high;
  final String low;
  final String close;

  Book({
    required this.unix,
    required this.date,
    required this.symbol,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      unix: json['unix'] ?? '',
      date: json['date'] ?? '',
      symbol: json['symbol'] ?? '',
      open: json['open'] ?? '',
      high: json['high'] ?? '',
      low: json['low'] ?? '',
      close: json['close'] ?? '',
    );
  }
}
