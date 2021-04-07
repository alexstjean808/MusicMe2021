class User {
  final String displayName;
  final String email;
  final String email_full;

  User({this.displayName, this.email, this.email_full});
  User.fromJson(Map<String, dynamic> json)
      : displayName = json["display_name"],
        email = json["email"]
            .substring(0, json["email"].indexOf('@'))
            .replaceAll(
                new RegExp(r'[^\w\s]+'), '_'), // removes all special characters
        email_full = json["email"];
}
