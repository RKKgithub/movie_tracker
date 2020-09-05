class DataModel {
  DataModel({
    this.contentName,
    this.contentType,
    this.contentPlot,
    this.contentLanguage,
    this.contentGenre,
    this.contentPosterURL,
    this.contentRating,
  });

  final String contentName;
  final String contentType;
  final String contentPlot;
  final String contentLanguage;
  final String contentGenre;
  final String contentPosterURL;
  final String contentRating;

  String status;
}
