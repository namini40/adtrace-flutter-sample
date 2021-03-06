import 'package:adtrace_sdk/adtrace.dart';
import 'package:adtrace_sdk/adtrace_config.dart';
import 'package:adtrace_sdk/adtrace_event.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo AdTrace'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {


  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initAdTrace();
  }


  void _initAdTrace() {
    AdTraceConfig config = new AdTraceConfig('ivaeqw8j46wp', AdTraceEnvironment.sandbox);
    config.logLevel = AdTraceLogLevel.verbose;
    AdTrace.start(config);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.inactive:
          break;
        case AppLifecycleState.resumed:
          AdTrace.onResume();
          break;
        case AppLifecycleState.paused:
          AdTrace.onPause();
          break;
        case AppLifecycleState.detached:
          break;
      }
    });
  }



  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    AdTraceEvent event = AdTraceEvent('58qw1h');
    AdTrace.trackEvent(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

}


