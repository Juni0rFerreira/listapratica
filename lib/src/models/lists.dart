class Lists {
  String id;
  String month;

  Lists({required this.id, required this.month});

  Lists.fromMap(Map<String, dynamic> map)
  :id = map["id"],
  month = map["month"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "month": month,
    };
  }
}