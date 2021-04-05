class User {
  final displayName;
  final email;

  User({this.displayName, this.email});
  User.fromJson(Map<String, dynamic> json)
      : displayName = json["display_name"],
        email = json["email"];
}
