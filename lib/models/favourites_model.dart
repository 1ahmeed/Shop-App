class FavouritesModel {
  late bool? status;
  // late void message;
 late Data? data;


  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  late int? currentPage;
  late List<FavouritesData>? data;
  late String? firstPageUrl;
  late int? from;
  late int? lastPage;
  late String? lastPageUrl;
  late String? path;
  late int? perPage;
  late int? to;
  late int? total;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavouritesData>[];
      json['data'].forEach((v) {
        data!.add( FavouritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }


}

class FavouritesData {
  late int? id;
 late Product? product;

  FavouritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}

class Product {
  late  int? id;
  dynamic price;
  dynamic oldPrice;
  late int? discount;
  late String? image;
  late String? name;
  late String? description;

  Product(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
