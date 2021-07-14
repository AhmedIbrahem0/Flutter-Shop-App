class HomeResponse {
  late bool status;
  late HomeData data;
  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = HomeData.fromJson(json["data"]);
  }
}

class HomeData {
    List<Banners> banners=[];
    List<Product> products=[];
  HomeData.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((item) {
      banners.add(Banners(id: item["id"], image: item["image"]));
    });
    json["products"].forEach((item) {
      products.add(Product(
          id: item["id"],
          price: item["price"],
          oldPrice: item["old_price"],
          discount: item["discount"],
          name: item["name"],
          description:item["description"],
          isFav:item["in_favorites"],

          image: item["image"]));
    });
  }
}

class Banners {
  final int id;
  final String image;
  Banners({required this.id, required this.image});
}

class Product {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  final String name;
  final String description;
  final String image;
    bool isFav;

  Product(
      {required this.id,
      required this.price,
      required this.oldPrice,
      required this.discount,
      required this.name,
      required this.description,
      required this.image,
      required this.isFav

      
      });
}
