import 'dart:convert';

class Item{

  int? id;
  String? nome;
  String? descrizione;
  String? urlimmagine;
  int? quantita;
  int? tipoProdotto;
  double? prezzo;
  bool selected;

  Item({
    required this.id,
    required this.nome,
    required this.descrizione,
    required this.urlimmagine,
    required this.quantita,
    required this.tipoProdotto,
    required this.prezzo,
    this.selected = false
  });

  Item.fromJson(Map<String,dynamic> json)
    : id = json['id_ingredient'],
      nome = json['nome'],
      descrizione = json['descrizione'],
      urlimmagine = json['urlimmagine'],
      quantita = json['quantità'],
      tipoProdotto = json['tipo_prodotto'],
      prezzo = json['prezzo'],
      selected = false;
}

class CartItemGroupElement{

  final int groupId;
  final Item item;

  CartItemGroupElement({
    required this.groupId,
    required this.item
  });

  Map<String, dynamic> toJson() => {
    'id_raggruppamento': groupId,
    'id_ingrediente': jsonEncode(item.id)
  };

}

class CartItem{

  final int id;
  final List<CartItemGroupElement> group;

  CartItem({
    required this.id,
    required this.group
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'group': jsonEncode(group),
  };
}

class Cart{
  static List<CartItem> storedCartItems = [];

  static void addCartItem(List<Item> item){
    final latestId = (storedCartItems.isEmpty)? 0 : storedCartItems.last.id;
    final latestGroupId = (storedCartItems.isEmpty)? 0 : storedCartItems.last.group.last.groupId;
    if(item.length <= 1){
      final cartItemGroupElement = CartItemGroupElement(groupId: latestGroupId+1, item: item[0]);
      storedCartItems.add(CartItem(id: latestId + 1, group: [cartItemGroupElement]));
    }else if(item.length > 1){
      final cartItem = CartItem(id: latestId+1, group: []);
      final currentGroupId = latestGroupId+1;
      for(int i = 0; i < item.length; i++){
        cartItem.group.add(CartItemGroupElement(groupId: currentGroupId, item: item[i]));
      }
      storedCartItems.add(cartItem);
    }
  }

  static void removeCartItem(int cartItemId){
    storedCartItems.removeAt(cartItemId);
  }

  static String toJson() => jsonEncode(storedCartItems);
  static String toJsonOrder() {
    final List<CartItemGroupElement> totalOrder = [];
    for (var cartEl in storedCartItems) {
      for (var groupEl in cartEl.group) {
        totalOrder.add(groupEl);
      }
    }
    print(jsonEncode(totalOrder));
    return jsonEncode(totalOrder);
  }
}

class Order{

  String? orderStatus;
  List<dynamic> ingredients;

  Order.fromJson(Map<String, dynamic> json)
    : orderStatus = json['order_status'],
      ingredients = json['ingredienti'];

}