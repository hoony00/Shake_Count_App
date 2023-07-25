import 'package:flutter/material.dart';
import 'package:flutter_shake_app/red_box.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  RxInt _counter = RxInt(0);
  late ShakeDetector detector;

  @override
  void initState() {
    //WidgetsBindingObserver 객체가 필요한 addObsercer함수를 이용하기 위해 클래스에 with구문 사용
    //Implements는 모든 함수를 구현해야되서 믹싱 형태로 구현!
    WidgetsBinding.instance.addObserver(this);

    // 흔들림 감지
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          _counter++;
        });
      },
      shakeThresholdGravity: 1.5,
    );

    super.initState();
  }

  //메모리 Leak 방지
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      print("클릭!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RedBox(),
                Column(
                  children: [
                    const RedBox(),
                    '흔들어서 카운트를 올려보세요'
                        .text
                        .color(Colors.red)
                        .bold
                        .black
                        .size(20)
                        .isIntrinsic
                        .makeCentered()
                        .box
                        .withRounded(value: 50)
                        .color(Colors.white)
                        .height(40)
                        .make()
                        .pSymmetric(h: 10, v: 20),
                    const RedBox(),
                  ],
                ),
                const RedBox(),
              ],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        detector.startListening();
        break;
      case AppLifecycleState.inactive:
        // some code
        break;
      case AppLifecycleState.paused:
        detector.stopListening();
        // some code
        break;
      case AppLifecycleState.detached:
        // some code
        break;
      default:
        // Handle the case when state is AppLifecycleState.resumed
        break;
    }
  }
}
