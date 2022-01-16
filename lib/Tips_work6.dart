import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = TextEditingController();
  var game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          // เทียบเท่ากับ <div> ของ HTML
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),//ขอบมน
              color: Colors.pinkAccent.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.6),
                  offset: const Offset(10.0, 10.0),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                ),
              ]),

          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* Row(
                children: [
                  Container(width: 50.0, height: 50.0, color: Colors.blue),
                  Expanded(
                      child: Container(
                    width: 50.0,
                    height: 50.0,
                    //color: Colors.pink,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text('FLUTTER', textAlign: TextAlign.end,),
                        ),
                        alignment: Alignment.centerRight,
                  )),
                ],
              ),*/
              //SizedBox(height: 16.0,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 200),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GUESS ',
                          style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.purpleAccent,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              /*SizedBox(
                height: 10.0,
              ),*/
              //Expanded(child: Container()),//การยึดแท็บบน-ล่าง
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    border: OutlineInputBorder(),
                    hintText: 'ทายเลขตั้งแต่ 1 ถึง 100',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    //การทำงานเมื่อกดปุ่มรัน
                    String? input = _controller.text;
                    int? guess = int.tryParse(input);
                    if (guess == null) {
                      if (input.isNotEmpty) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('ERROR'),
                                content: Text('กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK')
                                  )
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('ERROR'),
                                content: Text('กรุณากรอกข้อมูล'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK')
                                  )
                                ],
                              );
                            });
                      }
                    }
                    var result = game.doGuess(guess!);
                    print(result);
                    if (result == 1) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('RESULT'),
                              content: Text(input + ' is TOO HIGH!, try again'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK')
                                )
                              ],
                            );
                          });
                    } else if (result == -1) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('RESULT'),
                              content: Text(input + ' is TOO LOW!, try again'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK')
                                )
                              ],
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('RESULT'),
                              content: Text(input +
                                  ' is CORRECT!\n Total guesses: ${game.guessCount}'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK')
                                )
                              ],
                            );
                          });
                    }
                  },
                  child: Text('GUESS',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              //SizedBox(height: 16.0,),
            ],
          ),
        ),
      ),
    );
  }
}