class DataModel {
  DataModel(
      {this.contentName,
      this.contentType,
      this.contentPlot,
      this.contentLanguage,
      this.contentGenre,
      this.contentPosterURL});

  final String contentName;
  final String contentType;
  final String contentPlot;
  final String contentLanguage;
  final String contentGenre;
  final String contentPosterURL;

  String status;
}
