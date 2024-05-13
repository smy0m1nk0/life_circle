import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('did change dependency is called');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(count.toString()),
          ),
          body: CountState(
            count: 1000,
            increment: _increment,
            child: const Home(),
          )),
    );
  }

  void _increment() {
    setState(() {
      count++;
    });
  }
}


class CountState extends InheritedWidget {

  final int count;
  final Function increment;


  const CountState({super.key,required this.count, required super.child,required this.increment});

  static CountState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CountState>())!;
  }

  @override
  bool updateShouldNotify(CountState oldWidget) {
    //return true; //check inherit widget
    return false;
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('did change dependency is called');
  }
  @override
  Widget build(BuildContext context) {
    final CountState countState = CountState.of(context);
    return  Center(child: InkWell(
        onTap: (){
          countState.increment();
        },
        child: Text('Hello ${countState.count}')),);
  }
}