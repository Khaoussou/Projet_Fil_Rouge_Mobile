class CoursResponse {
  final int statut;
  final String message;
  final Data data;

  CoursResponse(
      {required this.statut, required this.message, required this.data});

  factory CoursResponse.fromJson(Map<String, dynamic> json) {
    return CoursResponse(
      statut: json['statut'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final List<Cours> cours;

  Data({required this.cours});

  factory Data.fromJson(Map<String, dynamic> json) {
    List<Cours> coursList =
        List<Cours>.from(json['cours'].map((c) => Cours.fromJson(c)));
    return Data(cours: coursList);
  }
}

class Cours {
  final int courId;
  final String semestre;
  final String module;
  final String etat;
  final String professeur;
  final List<CoursDetails> coursDetails;

  Cours({
    required this.courId,
    required this.semestre,
    required this.module,
    required this.etat,
    required this.professeur,
    required this.coursDetails,
  });

  factory Cours.fromJson(Map<String, dynamic> json) {
    List<CoursDetails> coursDetailsList = List<CoursDetails>.from(
      json['cours'].map((c) => CoursDetails.fromJson(c)),
    );

    return Cours(
      courId: json['cour_id'],
      semestre: json['semestre'],
      module: json['module'],
      etat: json['etat'],
      professeur: json['professeur'],
      coursDetails: coursDetailsList,
    );
  }
}

class CoursDetails {
  final String nbrHeure;

  CoursDetails({required this.nbrHeure});

  factory CoursDetails.fromJson(Map<String, dynamic> json) {
    return CoursDetails(nbrHeure: json['nbr_heure']);
  }
}
