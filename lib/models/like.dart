class Like {
  String? like;
  String? post_id;
  String? user_id;

  Like({
    this.like,
    this.post_id,
    this.user_id,
  });
// Function to convert JSON data to Medicament model
  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      like: json['data']['like'],
      post_id: json['data']['post_id'],
      user_id: json['data']['user_id'],
    );
  }
}