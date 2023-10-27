class SessionResponse {
  final int status;
  final String message;
  final SessionData data;

  SessionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return SessionResponse(
      status: json['statut'],
      message: json['message'],
      data: SessionData.fromJson(json['data']),
    );
  }
}

class SessionData {
  final List<Session> sessions;

  SessionData({
    required this.sessions,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> sessionList = json['sessions'];
    final List<Session> sessions = sessionList
        .map((sessionJson) => Session.fromJson(sessionJson))
        .toList();

    return SessionData(sessions: sessions);
  }
}

class Session {
  final int id;
  final String date;
  final String heureDebut;
  final String heureFin;
  final String salle;
  final String module;
  final String image;

  Session({
    required this.id,
    required this.date,
    required this.heureDebut,
    required this.heureFin,
    required this.salle,
    required this.module,
    required this.image,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      date: json['date'],
      heureDebut: json['heure_debut'],
      heureFin: json['heure_fin'],
      salle: json['salle'],
      module: json['module'],
      image: json['image'],
    );
  }
}
