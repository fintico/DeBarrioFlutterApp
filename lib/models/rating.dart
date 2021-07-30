class Rating {
  double rated;

  Rating({
    this.rated,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rated: json['rated_value'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rated_value': rated,
    };
  }
}
