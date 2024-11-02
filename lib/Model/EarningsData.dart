class EarningsData {
  final String? pricedate;
  final int? actual_revenue;
  final int? estimated_revenue;
  final String? ticker;


  EarningsData({
    required this.pricedate,
    required this.estimated_revenue,
    required this.actual_revenue,
    required this.ticker,

  });

  factory EarningsData.fromJson(Map<String, dynamic> json) {
    return EarningsData(
      pricedate: json['pricedate'],
      estimated_revenue: json['estimated_revenue'],
      actual_revenue: json['actual_revenue'],
      ticker: json['ticker'],
    );
  }
}