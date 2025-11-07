class NewParcelPudoModel {
  final String pudoAddress;
  final String pudoName;
  final String responsibleName;
  final String responsiblePhoneNumber;

  NewParcelPudoModel({
    required this.pudoAddress,
    required this.pudoName,
    required this.responsibleName,
    required this.responsiblePhoneNumber,
  });

  factory NewParcelPudoModel.fromJson(Map<String, dynamic> json) {
    return NewParcelPudoModel(
      pudoAddress: json['pudo_address'] ?? '',
      pudoName: json['pudo_name'] ?? '',
      responsibleName: json['responsible_name'] ?? '',
      responsiblePhoneNumber: json['responsible_phone_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pudo_address': pudoAddress,
      'pudo_name': pudoName,
      'responsible_name': responsibleName,
      'responsible_phone_number': responsiblePhoneNumber,
    };
  }
}
