import 'package:message/blocs/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

// app bloc
class ApplicationBloc implements BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();

  // app事件传输
  Sink<int> get _appEventSink => _appEvent.sink;

  // app事件流
  Stream<int> get appEventStream => _appEvent.stream;

  @override
  void dispose() {
    _appEvent.close();
  }

  // 获取数据
  @override
  Future getData({String labelId, int page}) {
    return null;
  }

  // 加载更多
  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  // 正在刷新
  @override
  Future onRefresh({String labelId}) {
    return null;
  }

  // 发送app事件
  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }
}
