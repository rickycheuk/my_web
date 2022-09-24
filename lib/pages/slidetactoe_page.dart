import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_web/constants.dart';

import '../utils/app_page_container.dart';
import '../utils/button_widgets.dart';

const int rowCount = 3;
const double maxBoardWidth = 300.0;

class SlideTacToePage extends StatefulWidget {
  const SlideTacToePage({Key? key}) : super(key: key);

  @override
  _SlideTacToePageState createState() => _SlideTacToePageState();
}

class _SlideTacToePageState extends State<SlideTacToePage> {
  final Map iconMap = {1: Icons.circle_outlined, 2: Icons.close};
  List tileList = List.filled(rowCount * rowCount, 0);
  int turn = 1;
  int tilePlaced = -1;
  Color textColor = kContentColorDarkTheme;

  @override
  void initState() {
    super.initState();
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
    return AppPageContainer(key: itemKey, children: [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.center,
        width: minBoardWidth,
        decoration: BoxDecoration(
            color:
                textColor == kContentColorDarkTheme ? Colors.white.withOpacity(0.69) : Colors.black.withOpacity(0.420),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color:
                    textColor == kContentColorDarkTheme ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
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
            return _buildTile(index, tileList[index], Theme.of(context).colorScheme.primary, iconSize);
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
                  iconTextButton(
                      text: "Confirm",
                      icon: Icons.check_circle_outline_rounded,
                      buttonColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.secondary,
                      onPressed: () async {
                        await HapticFeedback.lightImpact();
                        if (tilePlaced != -1) {
                          _checkWinner();
                          setState(() {
                            turn = turn == 1 ? 2 : 1;
                            tilePlaced = -1;
                          });
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  alignment: Alignment.center,
                                  title: const Text(
                                    "Tile not placed",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          const Text("Drag and drop tile into the grid."),
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
                      }),
                  SizedBox(height: 20),
                  iconTextButton(
                      text: "Give Up",
                      icon: Icons.flag_outlined,
                      buttonColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.secondary,
                      onPressed: () async {
                        await HapticFeedback.lightImpact();
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              String symbol = turn == 1 ? 'O' : 'X';
                              return AlertDialog(
                                scrollable: true,
                                alignment: Alignment.center,
                                title: Text(
                                  "$symbol gave up...",
                                  textAlign: TextAlign.center,
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        plainTextButton(
                                            textColor: textColor,
                                            height: 40,
                                            text: "Play Again",
                                            onPressed: () {
                                              _resetBoard();
                                              Navigator.pop(context);
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                ],
              ),
              SizedBox(width: 35),
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
                  child: fixedTile(iconMap[turn], iconSize)),
            ],
          )),
      SizedBox(height: 10),
    ]);
  }

  Widget fixedTile(IconData icon, double iconSize) {
    return Icon(
      icon,
      size: iconSize,
    );
  }

  Widget _buildTile(int index, int state, Color tileColor, double iconSize) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: index == tilePlaced ? tileColor.withOpacity(0.420) : tileColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 3,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: IconButton(
        icon: state != 0 ? fixedTile(iconMap[state], iconSize) : Container(),
        onPressed: () async {
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
        },
      ),
    );
  }

  void _checkWinner() {
    int winner = 0;
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
          _showWinDialog(winner.toString());
          return;
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
          _showWinDialog(winner.toString());
          return;
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
        _showWinDialog(winner.toString());
        return;
      }

      winner = player;
      for (int i = 0; i < rowCount; i++) {
        if (tileList[i * rowCount + rowCount - 1 - i] != player) {
          winner = 0;
          break;
        }
      }
      if (winner == player) {
        _showWinDialog(winner.toString());
        return;
      }
    }
    if (winner == 0 && !tileList.contains(0)) {
      _showDrawDialog();
      return;
    }
  }

  void _showWinDialog(String winner) {
    String symbol = winner == '1' ? 'O' : 'X';
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            alignment: Alignment.center,
            title: Text(
              "Winner is $symbol !!!",
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    plainTextButton(
                        textColor: textColor,
                        height: 40,
                        text: "Play Again",
                        onPressed: () {
                          _resetBoard();
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            alignment: Alignment.center,
            title: const Text(
              "Draw",
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    plainTextButton(
                        textColor: textColor,
                        height: 40,
                        text: "Play Again",
                        onPressed: () {
                          _resetBoard();
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
      turn = 1;
      tilePlaced = -1;
    });
  }
}
