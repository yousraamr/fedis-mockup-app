import 'form_field_data.dart';

class Service {
  final String? serviceName;
  final String? serviceLink;
  final String? serviceImage;
  final List<FormFieldData>? formData;

  Service({this.serviceName, this.serviceLink, this.serviceImage, this.formData});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceName: json['serviceName'],
    serviceLink: json['serviceLink'],
    serviceImage: json['serviceImage'],
    formData: (json['formData'] as List?)?.map((e) => FormFieldData.fromJson(e)).toList(),
  );
}