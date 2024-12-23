class Users {
  String nom;
  String prenom;
  String? datedeNaissance;
  String? phoneNumber;
  String email;
  Users(
      {required this.nom,
      required this.prenom,
      this.datedeNaissance,
      required this.email,
      this.phoneNumber});

  Map<String, String> toJson() {
    return {
      "nom": nom,
      "prenom": prenom,
      "dateDeNaissance": datedeNaissance ?? "",
      "email": email,
      "num": phoneNumber ?? "",
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        nom: json['nom'] as String,
        datedeNaissance: json['dateDeNaissance'] as String,
        prenom: json['prenom'] as String,
        email: json['email'] as String,
        phoneNumber: json['num'] as String);
  }
}
