/*
 * класс подписанный на изменения координат локации устройства
 * осуществялет стабилизацию, фильтрацию и прореживание получаемых
 * данных.
 * производится рассчет пройденного растояния (между двумя точками)
 * сохранение данных о перемещении в течении дня в массивы
 * сохранение массивов на устройство хранения
 * передает данные для отображения текущего положения и трека на карту
*/

import 'dart:async';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyTracking = 'GoTracking';

class LocationServices {
  LocationServices() {
    _trackingOn = true;
    _gpsInitSettings();
    _load();
    // передаем данные дальше
    _locationStream = _location.onLocationChanged.listen((l) {
      _outGpsPosition(l);
    });
  }

  // доступ к ресурсам
  bool _gpsEnabled;
  PermissionStatus _gpsPermission;
  // установки датчика
  LocationAccuracy _accuracy = LocationAccuracy.powerSave;
  int _interval = 1000;
  double _distance = 10;
  // вкл/откл слежения за положением
  bool _trackingOn;

  // датчик перемещений GPS
  static final Location _location = Location();
  StreamSubscription<LocationData> _locationStream;

  // <-- выдача данных для карты //.broadcast();
  final StreamController<LocationData> _locationControl =
      StreamController<LocationData>(); //.broadcast();
  get locationPosition => _locationControl.stream;

  // "слежения за треком"
  get trackingOn {
    return _trackingOn;
  }

  // установка нового значения "слежения за треком"
  set trackingOn(bool value) {
    this._trackingOn = value;
    SharedPreferences.getInstance().then((_pref) {
      _pref.setBool(keyTracking, value);
    });
  }

  // обрабатываем поток кординат изменения положения GPS и передаем далее
  _outGpsPosition(LocationData l) {
    // можно добавить фильтрацию и прореживание
    if (trackingOn) _locationControl.add(l);
  }

  // получить текущие координаты устройства и отправить их в поток для карт
  getLocationPosition() async {
    // запрос включения GPS
    _gpsEnabled = await _location.serviceEnabled();
    if (!_gpsEnabled) {
      _gpsEnabled = await _location.requestService();
      if (!_gpsEnabled) return;
    }
    // запрос разрешений на доступ к GPS
    _gpsPermission = await _location.hasPermission();
    if (_gpsPermission == PermissionStatus.denied) {
      _gpsPermission = await _location.requestPermission();
      if (_gpsPermission != PermissionStatus.granted) return;
    }
    // получение текущего положения
    await _location.getLocation().then((l) => _locationControl.add(l));
  }

  // настройки GPS
  void _gpsInitSettings() async {
    await _location.changeSettings(
        accuracy: _accuracy, interval: _interval, distanceFilter: _distance);
  }

  // загрузка сохраненных настрое
  _load() async {
    var _pref = await SharedPreferences.getInstance();
    _pref.containsKey(keyTracking)
        ? _trackingOn = _pref.getBool(keyTracking) ?? true
        : _pref.setBool(keyTracking, _trackingOn);
  }

  // удаление подписок
  dispose() {
    _locationStream?.cancel();
    _locationControl?.close();
  }
  
}
