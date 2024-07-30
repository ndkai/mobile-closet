class BaseParams{
  final String? keyword;
  final String? language;
  final String? locationCode;

  BaseParams({ this.keyword, this.language,  this.locationCode});

  factory BaseParams.fromJson(Map<String, dynamic> json) {
    return BaseParams(
      language: json['language'] ?? "",
      locationCode: json['locationCode'] ?? "",
      keyword: json['keyword'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (keyword != null) data['keyword'] = keyword;
    if (language != null) data['language'] = language;
    if (locationCode != null) data['locationCode'] = locationCode;
    return data;
  }
}

class BaseAuthParams{
  final String? token;
  final String? userUuid;
  BaseAuthParams({ this.userUuid, this.token});

  factory BaseAuthParams.fromJson(Map<String, dynamic> json) {
    return BaseAuthParams(
      userUuid: json['userUuid'] ?? "",
      token: json['token'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userUuid != null) data['userUuid'] = userUuid;
    if (token != null) data['token'] = token;
    return data;
  }
}