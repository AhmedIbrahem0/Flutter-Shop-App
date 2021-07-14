class CategoryModel {
  late bool status;
  late CategoryDataContent data;
  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = CategoryDataContent.fromJson(json["data"]);
  }
}

class CategoryDataContent {
    late int currentPage;
  List<CategoryData> data = [];
  CategoryDataContent.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"].forEach((element) {
      data.add(CategoryData(
          id: element["id"], image: element["image"], name: element["name"]));
    });
  }
}

class CategoryData {
  late int id;
  late String name;
  late String image;
  CategoryData({required this.id, required this.name, required this.image});
}
