class GetFavData {
  late bool status;
  late String message;
  late FavModel favModel;
  GetFavData.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    favModel = FavModel.fromJson(json["data"]);
  }
}

class FavModel {
  late int currentPage;
  List<FavProduct> favouriteList = [];
  FavModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"].forEach((item) {
      favouriteList.add(FavProduct(
          productId: item["product"]["id"],
          globalId: item["id"],
          price: item ["product"]["price"],
          oldPrice: item["product"]["old_price"],
          discount: item["product"]["discount"],
          name: item["product"]["name"],
          description: item["product"]["description"],
          image: item["product"]["image"]));
    });
  }
}

class FavProduct {
  final int globalId;
  final int productId;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  final String name;
  final String description;
  final String image;
  FavProduct({
    required this.productId,
    required this.globalId,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.name,
    required this.description,
    required this.image,
  });
}
