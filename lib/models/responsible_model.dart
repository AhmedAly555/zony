class ResponsibleModel {
  final String id;
  final String name;
  final String phoneNumber;

  ResponsibleModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory ResponsibleModel.fromJson(Map<String, dynamic> json) {
    return ResponsibleModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone_number': phoneNumber,
  };
}
