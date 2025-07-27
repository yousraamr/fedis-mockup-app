class ProductDataModel {
  String? serviceName;
  String? serviceLink;
  String? serviceImage;

  ProductDataModel({
    this.serviceName,
    this.serviceLink,
    this.serviceImage
  });

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    serviceLink = json['serviceLink'];
    serviceImage = json['serviceImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceName'] = this.serviceName;
    data['serviceLink'] = this.serviceLink;
    data['serviceImage'] = this.serviceImage;
    return data;
  }
}