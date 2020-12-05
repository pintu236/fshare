import 'package:device_apps/device_apps.dart';

class CustomApplication {
  Application _application;
  bool _isChecked = false;

  CustomApplication(this._application, this._isChecked);

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
  }

  Application get application => _application;

  set application(Application value) {
    _application = value;
  }
}
