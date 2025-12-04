class BaseResponse {
  final bool success;
  final dynamic data;
  final String? message;

  BaseResponse({required this.success, required this.data, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'] ?? false,
      data: json['data'],
      message: json['message'],
    );
  }
}
