class UserModel {
  final String name;
  final String? id;
  final String email;
  // final String gender;
  final String sec;
  final String batch;
  final String branch;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    //  required this.gender,
    required this.sec,
    required this.batch,
    required this.branch,
  });

  toJson() {
    return {
      "name": name,
      "email": email,
      // "gender": gender,
      "sec": sec,
      "batch": batch,
      "branch": branch,
    };
  }
}
