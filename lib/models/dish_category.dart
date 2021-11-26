class DishCategory {
  int? id;
  String? dishCategoryDescription;

  DishCategory({this.id, this.dishCategoryDescription});

  factory DishCategory.fromJson(Map<String, dynamic> json) {
    return DishCategory(
      id: json['id'] as int,
      dishCategoryDescription: json['dish_category_description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dish_category_description': dishCategoryDescription,
    };
  }
}
