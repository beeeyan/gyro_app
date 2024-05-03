import 'dart:io';

String get baseUrl {
  return Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api';
}
