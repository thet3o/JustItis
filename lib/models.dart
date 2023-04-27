class Item{

  int id;
  String nome;
  String descrizione;
  String urlimmagine;
  int quantita;
  int tipoProdotto;
  double prezzo;

  Item({
    required this.id,
    required this.nome,
    required this.descrizione,
    required this.urlimmagine,
    required this.quantita,
    required this.tipoProdotto,
    required this.prezzo
  });

  Item.fromJson(Map<String,dynamic> json)
    : id = json['id'],
      nome = json['nome'],
      descrizione = json['descrizione'],
      urlimmagine = json['urlimmagine'],
      quantita = json['quantità'],
      tipoProdotto = json['tipo_prodotto'],
      prezzo = json['prezzo'];
}