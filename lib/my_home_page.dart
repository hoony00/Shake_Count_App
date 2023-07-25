
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  int _counter = 0;


  @override
  void initState() {
    //WidgetsBindingObserver 객체가 필요한 addObsercer함수를 이용하기 위해 클래스에 with구문 사용
    //Implements는 모든 함수를 구현해야되서 믹싱 형태로 구현!
    WidgetsBinding.instance.addObserver(this);

    // 흔들림 감지
    ShakeDetector.autoStart(
      onPhoneShake: (){
      setState(() {
      _counter++;

      });
    }, shakeThresholdGravity: 1.5,
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
            const Text(
              '흔들어서 카운트 앱!',
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

}