class Rooms{
  String? from;
  String? to;

  Rooms({ required this.from, required this.to});

  factory Rooms.fromJson(Map<String, dynamic> json){
    return switch(json){
      {
      'from': String from,
      'to': String to
      } => Rooms(from: from, to: to),
      _ => throw const FormatException('Gagal membuat room')
    };
  }

  Map<String, dynamic> toJson(){
    return {
      'from' : this.from,
      'to' : this.to
    };
  }

}