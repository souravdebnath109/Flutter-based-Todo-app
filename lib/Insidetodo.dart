class Insidetodo {
  String id;
  String todotext;
  bool isdone;

  Insidetodo({
    required this.id,
    required this.todotext,
    required this.isdone,
  });
//store
  Map<String, dynamic> toJson() => {
    'id': id,
    'todotext': todotext,
    'isdone': isdone,
  };
//retrieve
  factory Insidetodo.fromJson(Map<String, dynamic> json) {
    return Insidetodo(
      id: json['id'],
      todotext: json['todotext'],
      isdone: json['isdone'],
    );
  }
}
