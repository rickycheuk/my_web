import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_web/constants.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/game_model.dart';
import '../utils/app_page_container.dart';
import '../utils/button_widgets.dart';

final _fireStore = FirebaseFirestore.instance;
const int rowCount = 3;
const double maxBoardWidth = 300.0;
final gameDatabase = _fireStore.collection('tictactoe');

class SlideTacToePage extends StatefulWidget {
  const SlideTacToePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  _SlideTacToePageState createState() => _SlideTacToePageState();
}

class _SlideTacToePageState extends State<SlideTacToePage> {
  final Map iconMap = {1: Icons.circle_outlined, 2: Icons.close};
  Color textColor = kContentColorDarkTheme;

  int turn = 1;
  int playerSymbol = 1;
  int tilePlaced = -1;
  String? currentLobby;
  List players = [];
  List localBoard = List.filled(rowCount * rowCount, 0);

  bool startGame = false;
  Widget? resultPage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> queueLobby(List<GameModel> gameList, String userId) async {
    debugPrint("Checking existing lobbies");
    // check if user already in lobby, update game status if so
    for (var lobby in gameList) {
      if (lobby != '0') {
        if (lobby.players.length == 1) {
          if (lobby.exited.contains(lobby.players[0])) {
            debugPrint("Found 1 player lobby with all players exited: ${lobby.id!}");
            deleteLobby(lobby.id!);
          } else if (!lobby.players.contains(userId)) {
            List players = lobby.players;
            players.add(userId);
            String firstPlayer = players[Random().nextInt(players.length)];
            debugPrint("Entering lobby: ${lobby.id}");
            await gameDatabase.doc(lobby.id).set({'players': players, 'o': firstPlayer}, SetOptions(merge: true));
            await Future.delayed(const Duration(seconds: 1), () {});
            debugPrint("Starting game: $currentLobby");
            return;
          }
        }
      }
    }
    debugPrint("No other players waiting in lobby");
    // create a new lobby if no lobbies available
    if (currentLobby == null) {
      var uuid = const Uuid();
      String lobbyId = uuid.v4();
      setState(() {
        currentLobby = lobbyId;
      });
      debugPrint("Creating lobby: $currentLobby");
      await gameDatabase.doc(lobbyId).set({
        'o': widget.userId,
        'board': localBoard,
        'players': [widget.userId],
        'exited': [],
        'turn': 1,
      }, SetOptions(merge: true));
      await Future.delayed(const Duration(seconds: 1), () {});
    }
  }

  Future<void> syncGameData(List<GameModel> gameList, String userId) async {
    for (GameModel lobby in gameList) {
      // both player exited lobby
      if (lobby.exited.length >= 2) {
        debugPrint("Found 2 players lobby with all players exited: ${lobby.id!}");
        deleteLobby(lobby.id!);
      }
      // if current user still in the lobby
      else if (lobby.players.contains(userId) && !lobby.exited.contains(userId)) {
        // update local app state
        setState(() {
          playerSymbol = lobby.o == widget.userId ? 1 : 2;
          localBoard = [...lobby.board];
          turn = lobby.turn;
          currentLobby = lobby.id;
          players = lobby.players;
          if (turn != playerSymbol) {
            tilePlaced = -1;
          }
          resultPage = _checkWinner(lobby.board);
        });
      }
    }
  }

  Future<void> exitLobby(String userId) async {
    await gameDatabase.doc(currentLobby).set({
      "exited": FieldValue.arrayUnion([userId])
    }, SetOptions(merge: true));
    debugPrint("exiting lobby: $currentLobby");
  }

  Future<void> deleteLobby(String id) async {
    await gameDatabase.doc(id).delete();
    debugPrint("removing lobby: $currentLobby");
  }

  Future<void> updateTurn() async {
    await gameDatabase.doc(currentLobby).set({
      'board': localBoard,
      'turn': turn == 1 ? 2 : 1,
    }, SetOptions(merge: true));
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

    List<GameModel> gameList = Provider.of<List<GameModel>>(context);
    syncGameData(gameList, widget.userId);

    Widget? statusPage = Container();

    if (!startGame) {
      _resetBoard();
      // User not ready
      statusPage = iconTextButton(
          text: "Start",
          icon: Icons.play_arrow_rounded,
          buttonColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () async {
            await HapticFeedback.lightImpact();
            setState(() {
              startGame = true;
            });
          });
    } else if (resultPage != null) {
      statusPage = resultPage!;
    } else {
      // Game started and both player are ready
      if (currentLobby != null && players.length == 2) {
        statusPage = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                confirmMoveButton(),
                const SizedBox(height: 20),
                giveUpButton(),
              ],
            ),
            const SizedBox(width: 20),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                turn == playerSymbol ? "Your Turn" : "Opponent's\nTurn",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              playerSymbolTile(iconSize),
            ])
          ],
        );
      } else {
        // User ready and not in a lobby yet
        if (currentLobby == null) {
          queueLobby(gameList, widget.userId);
        }

        statusPage = Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Waiting for opponent to join...'),
            const SizedBox(
              height: 10,
            ),
            iconTextButton(
                text: "Cancel",
                icon: Icons.close_rounded,
                buttonColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.secondary,
                onPressed: () async {
                  await HapticFeedback.lightImpact();
                  exitLobby(widget.userId);
                  _resetBoard();
                }),
          ],
        );
      }
    }

    return AppPageContainer(key: itemKey, children: [
      const SizedBox(height: 10),
      buildGameBoard(minBoardWidth, iconSize),
      Container(
          height: 180,
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 20),
          alignment: Alignment.center,
          child: statusPage)
    ]);
  }

  Widget fixedTile(IconData icon, double iconSize) {
    return Icon(
      icon,
      size: iconSize,
    );
  }

  Widget _buildTile(int index, int state, Color tileColor, double iconSize) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
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
              if (localBoard[index] == 0) {
                if (tilePlaced != -1) {
                  localBoard[tilePlaced] = 0;
                }
                localBoard[index] = turn;
                tilePlaced = index;
              }
            });
          }
        },
      ),
    );
  }

  Widget _buildDraggableTile(int index, int state, Color tileColor, double iconSize) {
    return Draggable<Map>(
      child: _buildTile(index, state, tileColor, iconSize),
      feedback: Container(),
      childWhenDragging: _buildTile(index, state, tileColor, iconSize),
      onDragStarted: () {},
    );
  }

  Widget? _checkWinner(List board) {
    int winner = 0;
    if (listEquals(board, List.filled(rowCount * rowCount, 1))) {
      return giveUpPage('1');
    }
    if (listEquals(board, List.filled(rowCount * rowCount, 2))) {
      return giveUpPage('2');
    }

    // 2 players
    for (int player in [1, 2]) {
      // Check rows
      for (int i = 0; i < rowCount; i++) {
        winner = player;
        for (int j = 0; j < rowCount; j++) {
          if (board[i * rowCount + j] != player) {
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
          if (board[j * rowCount + i] != player) {
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
        if (board[i * rowCount + i] != player) {
          winner = 0;
          break;
        }
      }
      if (winner == player) {
        return winPage(winner.toString());
      }

      winner = player;
      for (int i = 0; i < rowCount; i++) {
        if (board[i * rowCount + rowCount - 1 - i] != player) {
          winner = 0;
          break;
        }
      }
      if (winner == player) {
        return winPage(winner.toString());
      }
    }
    if (winner == 0 && !board.contains(0)) {
      return drawPage();
    }
    return null;
  }

  Widget winPage(String winner) {
    setState(() {
      turn = -1;
    });
    String result = winner == playerSymbol.toString() ? 'Won' : 'Lost';
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("You $result",
          textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 20,
      ),
      iconTextButton(
          text: "Play Again",
          icon: Icons.refresh_rounded,
          buttonColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () async {
            await HapticFeedback.lightImpact();
            exitLobby(widget.userId);
            _resetBoard();
          }),
    ]);
  }

  Widget drawPage() {
    setState(() {
      turn = -1;
    });
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Draw", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 20,
      ),
      iconTextButton(
          text: "Play Again",
          icon: Icons.refresh_rounded,
          buttonColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () async {
            await HapticFeedback.lightImpact();
            exitLobby(widget.userId);
            _resetBoard();
          }),
    ]);
  }

  Widget giveUpPage(String winner) {
    setState(() {
      turn = -1;
    });
    String loser = winner == playerSymbol.toString() ? 'Opponent' : 'You';
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("$loser Gave Up...",
          textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 20,
      ),
      iconTextButton(
          text: "Play Again",
          icon: Icons.refresh_rounded,
          buttonColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.secondary,
          onPressed: () async {
            await HapticFeedback.lightImpact();
            exitLobby(widget.userId);
            _resetBoard();
          }),
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
            localBoard[tilePlaced] = playerSymbol;
            updateTurn();
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
                    const SizedBox(height: 20),
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

  Widget giveUpButton() {
    return iconTextButton(
        text: "Give Up",
        icon: Icons.flag_outlined,
        buttonColor: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.secondary,
        onPressed: () async {
          List winningBoard = List.filled(rowCount * rowCount, playerSymbol == 1 ? 2 : 1);
          await HapticFeedback.lightImpact();
          await gameDatabase.doc(currentLobby).set({
            'board': winningBoard,
          }, SetOptions(merge: true));
          setState(() {
            tilePlaced = -1;
          });
        });
  }

  Widget playerSymbolTile(double iconSize) {
    return Container(
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
              color:
                  textColor == kContentColorDarkTheme ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
              width: 5),
        ),
        child: fixedTile(iconMap[playerSymbol], iconSize));
  }

  Widget buildGameBoard(double boardWidth, double iconSize) {
    return Container(
      alignment: Alignment.center,
      width: boardWidth,
      decoration: BoxDecoration(
          color: textColor == kContentColorDarkTheme ? Colors.white.withOpacity(0.69) : Colors.black.withOpacity(0.420),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  textColor == kContentColorDarkTheme ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
              width: 5)),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: rowCount,
        ),
        children: List.generate(localBoard.length, (index) {
          return _buildDraggableTile(index, localBoard[index], Theme.of(context).colorScheme.primary, iconSize);
        }),
      ),
    );
  }

  void _resetBoard() {
    setState(() {
      localBoard = List.filled(rowCount * rowCount, 0);
      tilePlaced = -1;
      currentLobby = null;
      startGame = false;
      turn = 1;
      playerSymbol = 1;
      resultPage = null;
    });
  }
}
