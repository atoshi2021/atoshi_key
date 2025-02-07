class CategorySubsetParams {
  String? icon;
  int categoryId;
  String categoryName;

  CategorySubsetParams(this.categoryId, this.categoryName, {this.icon});

  @override
  String toString() {
    return 'CategorySubsetParams{icon: $icon, categoryId: $categoryId, categoryName: $categoryName}';
  }
}
