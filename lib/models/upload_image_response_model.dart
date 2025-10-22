class UploadImageResponseModel {
  final String contentType;
  final int expiresIn;
  final String key;
  final String publicUrl;
  final String status;
  final String uploadUrl;

  UploadImageResponseModel({
    required this.contentType,
    required this.expiresIn,
    required this.key,
    required this.publicUrl,
    required this.status,
    required this.uploadUrl,
  });

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadImageResponseModel(
      contentType: json['content_type'] as String,
      expiresIn: json['expires_in'] as int,
      key: json['key'] as String,
      publicUrl: json['public_url'] as String,
      status: json['status'] as String,
      uploadUrl: json['upload_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "content_type": contentType,
    "expires_in": expiresIn,
    "key": key,
    "public_url": publicUrl,
    "status": status,
    "upload_url": uploadUrl,
  };
}
