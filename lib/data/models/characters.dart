class Character {
  late int charId;
  late String name;
  late String status;
  late String species;
  late String type;
  late String gender;
  late Map<String, String> origin;
  late Map<String, String> location;
  late String image;
  late List episode;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = json['origin'];
    location = json['location'];
    image = json['image'];
    episode = json['episode'];
  }
}
