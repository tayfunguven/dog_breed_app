import 'dart:async';
import 'package:dog_breed_app/Utils/os_info.dart';

class OSVersionBloc {
  final _osVersionController = StreamController<String>();

  Stream<String> get osVersionStream => _osVersionController.stream;

  OSVersionBloc() {
    _addOSVersionToStream();
  }

  Future<void> _addOSVersionToStream() async {
    String osVersion = OSInfo.getOSVersion();

    if (!_osVersionController.isClosed) {
      _osVersionController.sink.add(osVersion);
    }
  }

  void dispose() {
    _osVersionController.close();
  }
}

OSVersionBloc osVersionBloc = OSVersionBloc();