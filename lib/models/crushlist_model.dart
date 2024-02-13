class CrushListModel {
  final String name1;
  final String name2;
  final String name3;
  final String name4;
  final String name5;

  CrushListModel(
      {required this.name1,
      required this.name2,
      required this.name3,
      required this.name4,
      required this.name5});

  toJson() {
    return {
      "name1": name1,
      "name2": name2,
      "name3": name3,
      "name4": name4,
      "name5": name5,
    };
  }
}
