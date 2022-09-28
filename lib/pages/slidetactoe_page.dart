import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_web/constants.dart';
import 'package:uuid/uuid.dart';

import '../utils/app_page_container.dart';
import '../utils/button_widgets.dart';

final _fireStore = FirebaseFirestore.instance;
const int rowCount = 3;
const double maxBoardWidth = 300.0;

class SlideTacToePage extends StatefulWidget {
  const SlideTacToePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  _SlideTacToePageState createState() => _SlideTacToePageState();
}

class _SlideTacToePageState extends State<SlideTacToePage> {
  final Map iconMap = {1: Icons.circle_outlined, 2: Icons.close};
  List tileList = List.filled(rowCount * rowCount, 0);
  Color textColor = kContentColorDarkTheme;
  IconData? directionIcon;
  int? directionIndex;
  Offset beginningDragPosition = Offset(0.0, 0.0);

  int turn = 1;
  int playerSymbol = 1;
  int tilePlaced = -1;
  String? currentLobby;

  bool startGame = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getLobbyData() async {
    QuerySnapshot querySnapshot = await _fireStore.collection('tictactoe').get();
    // check if user already in lobby, update game status if so
    for (var lobby in querySnapshot.docs) {
      if (lobby != '0') {
        if (lobby.get('players').contains(widget.userId)) {
          debugPrint("Lobby found: ${lobby.get('players').toString()}, resuming");
          syncGameData(lobby);
          return;
        }
      }
    }
  }

  Future<void> queueLobby() async {
    QuerySnapshot querySnapshot = await _fireStore.collection('tictactoe').get();
    // check if user already in lobby, update game status if so
    for (var lobby in querySnapshot.docs) {
      if (lobby != '0') {
        if (lobby.get('players').length == 1 && !lobby.get('players').contains(widget.userId)) {
          List players = lobby.get('players');
          players.add(widget.userId);
          String firstPlayer = players[Random().nextInt(players.length)];
          debugPrint("Entering lobby: ${players.toString()}");
          await _fireStore
              .collection('tictactoe')
              .doc(lobby.id)
              .set({'players': players, 'O': firstPlayer}, SetOptions(merge: true));
          await Future.delayed(const Duration(seconds: 2), () {});
          syncGameData(lobby);
          debugPrint("Starting game: $currentLobby");
          return;
        }
      }
    }
    debugPrint("No other players waiting in lobby");
    // create a new lobby if no lobbies available
    if (currentLobby == null) {
      var uuid = Uuid();
      String lobbyId = uuid.v4();
      setState(() {
        currentLobby = lobbyId;
      });
      debugPrint("Creating lobby: $currentLobby");
      await _fireStore.collection('tictactoe').doc(lobbyId).set({
        'O': widget.userId,
        'board': tileList,
        'players': [widget.userId],
        'turn': 1,
      }, SetOptions(merge: true));
      await Future.delayed(const Duration(seconds: 2), () {});
    }
  }

  Future<void> syncGameData(QueryDocumentSnapshot lobby) async {
    setState(() {
      tileList = lobby.get('board');
      // get user's symbol
      playerSymbol = lobby.get('O') == widget.userId ? 1 : 2;
      turn = lobby.get('turn');
      currentLobby = lobby.id;
    });
  }

  Future<void> deleteLobby(String id) async {
    await _fireStore.collection('tictactoe').doc(id).delete();
    debugPrint("removing lobby: $currentLobby");
  }

  @override
  Widget build(BuildContext context) {
    final itemKey = GlobalKey();
    double width = MediaQuery.of(context).size.width;
    double minBoardWidth = min(width, maxBoardWidth);
    double iconSize = minBoardWidth / rowCount + 1 - (13 - min(rowCount, 13)) * 3;
    setState(() {
      textColor = Theme.of(context).textTheme.bodyText1?.color as Color;
    });

    if (!startGame) {
      return AppPageContainer(key: itemKey, children: [
        SizedBox(
          height: 20,
        ),
        iconTextButton(
            text: "Start Game",
            icon: Icons.play_arrow_rounded,
            buttonColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.secondary,
            onPressed: () async {
              await HapticFeedback.lightImpact();
              setState(() {
                startGame = true;
              });
            }),
        SizedBox(
          height: 10,
        ),
      ]);
    } else {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('tictactoe').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (currentLobby == null) {
                // check if player already have game in progress
                getLobbyData();
                // queue new lobby if no game in progress
                if (currentLobby == null) {
                  queueLobby();
                }
              }
              if (currentLobby != null) {
                for (var lobby in snapshot.data!.docs) {
                  if (lobby.id == currentLobby && lobby.get('players').length == 2) {
                    syncGameData(lobby);
                    debugPrint("check gave ups");
                    debugPrint(listEquals(tileList, List.filled(rowCount * rowCount, 1)).toString());
                    Widget? resultPage = _checkWinner();
                    if (resultPage != null) {
                      return resultPage;
                    }
                    return AppPageContainer(key: itemKey, children: [
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        width: minBoardWidth,
                        decoration: BoxDecoration(
                            color: textColor == kContentColorDarkTheme
                                ? Colors.white.withOpacity(0.69)
                                : Colors.black.withOpacity(0.420),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: textColor == kContentColorDarkTheme
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.black.withOpacity(0.1),
                                width: 5)),
                        child: GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: rowCount,
                          ),
                          children: List.generate(tileList.length, (index) {
                            return _buildDraggableTile(
                                index, tileList[index], Theme.of(context).colorScheme.primary, iconSize);
                          }),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  confirmMoveButton(),
                                  SizedBox(height: 20),
                                  iconTextButton(
                                      text: "Give Up",
                                      icon: Icons.flag_outlined,
                                      buttonColor: Theme.of(context).colorScheme.primary,
                                      textColor: Theme.of(context).colorScheme.secondary,
                                      onPressed: () async {
                                        await HapticFeedback.lightImpact();
                                        await _fireStore.collection('tictactoe').doc(currentLobby).set({
                                          'board': List.filled(rowCount * rowCount, playerSymbol == 1 ? 2 : 1),
                                        }, SetOptions(merge: true));
                                        await Future.delayed(const Duration(seconds: 1), () {});
                                      }),
                                ],
                              ),
                              SizedBox(width: 35),
                              Column(children: [
                                Container(
                                  child: Text(turn == playerSymbol ? "Your Turn" : "Opponent's Turn",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: 10),
                                Container(
                                    alignment: Alignment.center,
                                    height: iconSize + 15,
                                    width: iconSize + 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).colorScheme.primary,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 3,
                                          offset: const Offset(1, 3), // changes position of shadow
                                        ),
                                      ],
                                      border: Border.all(
                                          color: textColor == kContentColorDarkTheme
                                              ? Colors.white.withOpacity(0.5)
                                              : Colors.black.withOpacity(0.5),
                                          width: 5),
                                    ),
                                    child: fixedTile(iconMap[playerSymbol], iconSize)),
                              ])
                            ],
                          )),
                      SizedBox(height: 10),
                    ]);
                  }
                }
              }
            }
            Widget? resultPage = _checkWinner();
            if (resultPage != null) {
              return resultPage;
            }
            return AppPageContainer(key: itemKey, children: [
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: kPrimaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Waiting for opponent to join...'),
              SizedBox(
                height: 20,
              ),
              iconTextButton(
                  text: "Cancel",
                  icon: Icons.close_rounded,
                  buttonColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    deleteLobby(currentLobby!);
                    _resetBoard();
                  }),
              SizedBox(
                height: 10,
              ),
            ]);
          });
    }
  }

  Widget fixedTile(IconData icon, double iconSize) {
    return Icon(
      icon,
      size: iconSize,
    );
  }

  Widget _buildTile(int index, int state, Color tileColor, double iconSize) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: index == tilePlaced ? tileColor.withOpacity(0.420) : tileColor,
      elevation: 2,
      shadowColor: Colors.black,
      child: IconButton(
        icon: (state != 0
            ? fixedTile(iconMap[state], iconSize)
            : (index == tilePlaced && turn == playerSymbol ? fixedTile(iconMap[playerSymbol], iconSize) : Container())),
        onPressed: () async {
          if (turn == playerSymbol) {
            await HapticFeedback.lightImpact();
            setState(() {
              if (tileList[index] == 0) {
                if (tilePlaced != -1) {
                  tileList[tilePlaced] = 0;
                }
                tileList[index] = turn;
                tilePlaced = index;
              }
            });
          }
        },
      ),
    );
  }

  Widget _buildDraggableTile(int index, int state, Color tileColor, double iconSize) {
    return
        // Listener(
        //   //add
        //   onPointerDown: (details) {
        //     beginningDragPosition = details.position;
        //   },
        //   onPointerMove: (details) {
        //     Offset currentDragPosition = Offset(
        //       details.position.dx - beginningDragPosition.dx,
        //       details.position.dy - beginningDragPosition.dy,
        //     );
        //     setState(() {
        //       directionIndex = index;
        //     });
        //     if (currentDragPosition.dx.abs() > currentDragPosition.dy.abs()) {
        //       if (currentDragPosition.dx > 0) {
        //         setState(() {
        //           directionIcon = Icons.arrow_forward_rounded;
        //         });
        //       } else {
        //         setState(() {
        //           directionIcon = Icons.arrow_back_rounded;
        //         });
        //       }
        //     } else {
        //       if (currentDragPosition.dy < 0) {
        //         setState(() {
        //           directionIcon = Icons.arrow_upward_rounded;
        //         });
        //       } else {
        //         setState(() {
        //           directionIcon = Icons.arrow_downward_rounded;
        //         });
        //       }
        //     }
        //   },
        //   onPointerUp: (details) {
        //     setState(() {
        //       directionIcon = null;
        //       directionIndex = null;
        //     });
        //   },
        //   onPointerCancel: (details) {
        //     setState(() {
        //       directionIcon = null;
        //       directionIndex = null;
        //     });
        //   },
        //   child:
        Draggable<Map>(
      child: _buildTile(index, state, tileColor, iconSize),
      feedback: Container(),
      childWhenDragging: _buildTile(index, state, tileColor, iconSize),
      onDragStarted: () {},
      data: {},
      // )
    );
  }

  Widget? _checkWinner() {
    int winner = 0;
    if (listEquals(tileList, List.filled(rowCount * rowCount, 1))) {
      return giveUpPage('1');
    }
    if (listEquals(tileList, List.filled(rowCount * rowCount, 2))) {
      return giveUpPage('2');
    }

    // 2 players
    for (int player in [1, 2]) {
      // Check rows
      for (int i = 0; i < rowCount; i++) {
        winner = player;
        for (int j = 0; j < rowCount; j++) {
          if (tileList[i * rowCount + j] != player) {
            winner = 0;
            break;
          }
        }
        if (winner == player) {
          return winPage(winner.toString());
        }
      }

      // Check columns
      for (int i = 0; i < rowCount; i++) {
        winner = player;
        for (int j = 0; j < rowCount; j++) {
          if (tileList[j * rowCount + i] != player) {
            winner = 0;
            break;
          }
        }
        if (winner == player) {
          return winPage(winner.toString());
        }
      }

      // Check diagonals
      winner = player;
      for (int i = 0; i < rowCount; i++) {
        if (tileList[i * rowCount + i] != player) {
          winner = 0;
          break;
        }
      }
      if (winner == player) {
        return winPage(winner.toString());
      }

      winner = player;
      for (int i = 0; i < rowCount; i++) {
        if (tileList[i * rowCount + rowCount - 1 - i] != player) {
          winner = 0;
          break;
        }
      }
      if (winner == player) {
        return winPage(winner.toString());
      }
    }
    if (winner == 0 && !tileList.contains(0)) {
      return drawPage();
    }
    return null;
  }

  Widget winPage(String winner) {
    final itemKey = GlobalKey();
    String symbol = winner == '1' ? 'O' : 'X';
    deleteLobby(currentLobby!);
    return AppPageContainer(key: itemKey, children: [
      SizedBox(
        height: 20,
      ),
      Text("Winner is $symbol !!!",
          textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(
        height: 20,
      ),
      iconTextButton(
          text: "Play Again",
          icon: Icons.refresh_rounded,
          buttonColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            _resetBoard();
          }),
      SizedBox(
        height: 10,
      ),
    ]);
  }

  Widget drawPage() {
    final itemKey = GlobalKey();
    deleteLobby(currentLobby!);
    return AppPageContainer(key: itemKey, children: [
      SizedBox(
        height: 20,
      ),
      Text("Draw", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(
        height: 20,
      ),
      iconTextButton(
          text: "Play Again",
          icon: Icons.refresh_rounded,
          buttonColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            _resetBoard();
          }),
      SizedBox(
        height: 10,
      ),
    ]);
  }

  Widget giveUpPage(String winner) {
    final itemKey = GlobalKey();
    String loser = winner == '1' ? 'X' : 'O';
    deleteLobby(currentLobby!);
    return AppPageContainer(key: itemKey, children: [
      SizedBox(
        height: 20,
      ),
      Text("$loser gave up...",
          textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(
        height: 20,
      ),
      iconTextButton(
          text: "Play Again",
          icon: Icons.refresh_rounded,
          buttonColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            _resetBoard();
          }),
      SizedBox(
        height: 10,
      ),
    ]);
  }

  Widget confirmMoveButton() {
    return iconTextButton(
        text: "Confirm",
        icon: Icons.check_rounded,
        buttonColor: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.secondary,
        onPressed: () async {
          await HapticFeedback.lightImpact();
          if (tilePlaced != -1 && turn == playerSymbol) {
            tileList[tilePlaced] = playerSymbol;
            _updateTurn();
          } else if (turn != playerSymbol) {
            invalidMoveDialog("Not your turn yet");
          } else {
            invalidMoveDialog("Symbol not placed");
          }
        });
  }

  void invalidMoveDialog(String warningText) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            alignment: Alignment.center,
            title: Text(
              warningText,
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    plainTextButton(
                        textColor: textColor,
                        height: 40,
                        text: "OK",
                        onPressed: () {
                          // HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _resetBoard() {
    setState(() {
      tileList = List.filled(rowCount * rowCount, 0);
      tilePlaced = -1;
      currentLobby = null;
      startGame = false;
      turn = 1;
      playerSymbol = 1;
    });
  }

  Future<void> _updateTurn() async {
    setState(() {
      tilePlaced = -1;
    });
    await _fireStore.collection('tictactoe').doc(currentLobby).set({
      'board': tileList,
      'turn': turn == 1 ? 2 : 1,
    }, SetOptions(merge: true));
  }
}
