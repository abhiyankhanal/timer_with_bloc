import 'dart:async';

enum CounterAction { Start, Reset }

class CounterBloc {
  int counter;
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;
  CounterBloc() {
    Timer _timer;
    counter = 60;
    eventStream.listen((event) {
      if (event == CounterAction.Start) {
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (counter > 0) {
            counter--;
          } else {
            _timer.cancel();
          }
          if (event == CounterAction.Reset) {
            _timer.cancel();
            counter = 60;
          }
          counterSink.add(counter);
        });
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
