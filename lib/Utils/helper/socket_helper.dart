import 'package:chat_socket/Utils/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketHelper {
  static final SocketHelper _singleton = SocketHelper._internal();

  SocketHelper._internal();

  factory SocketHelper() => _singleton;

  late IO.Socket _socketIO;

  bool isConnected = false, isUserConnected = false;

  String tag = "socket";

  Future<void> init() async {
    _socketIO = IO.io(ApiConstants.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socketIO.connect();
    _initListener();
  }

  _initListener() {
    _socketIO.onConnect((data) {
      isConnected = true;
      if (ApiConstants.MY_USER_ID != null) {
        connectUser();
      }
      print('$tag connected');
    });
    _socketIO.onConnectError((data) {
      isConnected = false;
      print(data.toString());
    });
    _socketIO.onError((data) {
      print(data.toString());
    });

    _socketIO.on("connect_user", (data) {
      print("$tag user connected : $data");
    });
  }

  IO.Socket getSocket() => _socketIO;

  connectUser() {
    Map<String, dynamic> map = {"userId": ApiConstants.MY_USER_ID};
    isUserConnected = true;
    _socketIO.emit("connect_user", map);
    print("$tag connectUser called $map");
  }

  disconnectUser() {
    _socketIO.off("connect_user");
    isUserConnected = false;
  }

}
