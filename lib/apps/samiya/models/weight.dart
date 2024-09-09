class Weight {
  final double? value;
  final String? units;

  Weight({this.value, this.units});

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      value: (json['value'] as num?)?.toDouble(),
      units: json['units'] as String?,
    );
  }
}
