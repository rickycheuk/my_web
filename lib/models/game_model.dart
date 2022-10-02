import 'package:cloud_firestore/cloud_firestore.dart';

import '../pages/slidetactoe_page.dart';

class GameModel {
  final String? id;
  final String o;
  final List board;
  final List players;
  final int turn;
  final List exited;

  GameModel({required this.id, required this.o, required this.board, required this.players, required this.turn, required this.exited});

  factory GameModel.fromFirestore(DocumentSnapshot doc) {
    return GameModel(
      id: doc.id,
      o: doc.data().toString().contains('o') ? doc.get('o') : '',
      board: doc.data().toString().contains('board') ? doc.get('board') : List.filled(rowCount * rowCount, 0),
      players: doc.data().toString().contains('players') ? doc.get('players') : [],
      turn: doc.data().toString().contains('turn') ? doc.get('turn') : 0,
      exited: doc.data().toString().contains('exited') ? doc.get('exited') : [],
    );
  }
}
