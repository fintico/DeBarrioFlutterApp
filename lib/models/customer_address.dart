import 'address.dart';
import 'customer.dart';

class CustomerAddress {
  int id;
  Customer customer;
  Address address;

  CustomerAddress({this.id, this.customer, this.address});

  factory CustomerAddress.fromJson(Map<String, dynamic> json) {
    return CustomerAddress(
      id: json['id'] as int,
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer?.toJson(),
      'address': address?.toJson(),
    };
  }
}
