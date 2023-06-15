class Response {
  String? response;
  String? question_id;
  String? medic_id;
  String? user_id;

  Response({
    this.response,
    this.question_id,
    this.medic_id,
    this.user_id,
  });
  // Function to convert JSON data to Medicament model
  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      response: json['data']['response'],
      question_id: json['data']['question_id'],
      medic_id: json['data']['medic_id'],
      user_id: json['data']['user_id'],
    );
  }
}