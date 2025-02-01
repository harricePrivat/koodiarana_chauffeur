class Users {
  String nom;
  String prenom;
  String? datedeNaissance;
  String? phoneNumber;
  String email;
  String? pdpUrl;
  Users(
      {required this.nom,
      required this.prenom,
      this.datedeNaissance,
      this.pdpUrl,
      required this.email,
      this.phoneNumber});

  Map<String, String> toJson() {
    return {
      "photoProfil": pdpUrl!,
      "nom": nom,
      "prenom": prenom,
      "dateDeNaissance": datedeNaissance ?? "",
      "email": email,
      "num": phoneNumber ?? "",
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        pdpUrl: json['photoProfil'] as String,
        nom: json['nom'] as String,
        datedeNaissance: json['dateDeNaissance'] as String,
        prenom: json['prenom'] as String,
        email: json['email'] as String,
        phoneNumber: json['num'] as String);
  }
}
