class Actor {
  final String id;
  final String gender;
  final String name;
  final String profilePath;
  final String knowForDepartment;
  final String popularity;

  Actor(
      {required this.id,
      required this.gender,
      required this.name,
      required this.profilePath,
      required this.knowForDepartment,
      required this.popularity});

  factory Actor.fromJson(dynamic json) {
    return Actor(
        id: json['id'].toString(),
        gender: json['gender'].toString(),
        name: json['name'],
        profilePath: json['profile_path'],
        knowForDepartment: json['known_for_department'],
        popularity: json['popularity'].toString());
  }
}
