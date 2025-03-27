class ReelModel {
  final String image;
  final String song;
  final String lead;
  final String description;

  ReelModel({
    required this.image,
    required this.song,
    required this.lead,
    required this.description,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      image: json["image"] ?? "",
      song: json["song"] ?? "",
      lead: json["lead"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "song": song,
      "lead": lead,
      "description": description,
    };
  }
}
