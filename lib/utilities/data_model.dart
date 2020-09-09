class DataModel {
  DataModel({
    this.contentName,
    this.contentType,
    this.contentPlot,
    this.contentLanguage,
    this.contentGenre,
    this.contentPosterURL,
    this.contentRating,
    this.contentCast,
  });

  final String contentName;
  final String contentType;
  final String contentPlot;
  final String contentLanguage;
  final String contentGenre;
  final String contentPosterURL;
  final String contentRating;
  final String contentCast;

  String status;

  DataModel.fromJson(Map<String, dynamic> json)
      : contentName = json['contentName'],
        contentType = json['contentType'],
        contentPlot = json['contentPlot'],
        contentLanguage = json['contentLanguage'],
        contentGenre = json['contentGenre'],
        contentPosterURL = json['contentPosterURL'],
        contentRating = json['contentRating'],
        contentCast = json['contentCast'],
        status = json['contentStatus'];

  Map<String, dynamic> toJson() => {
        'contentName': contentName,
        'contentType': contentType,
        'contentPlot': contentPlot,
        'contentLanguage': contentLanguage,
        'contentGenre': contentGenre,
        'contentPosterURL': contentPosterURL,
        'contentRating': contentRating,
        'contentCast': contentCast,
        'contentStatus': status,
      };
}
