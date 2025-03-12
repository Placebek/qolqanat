import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _controller;
  bool _locationPermissionGranted = false;

  // Начальные координаты (Алматы, Казахстан)
  static const LatLng _initialPosition = LatLng(43.238949, 76.889709);

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  // Запрос разрешений на местоположение
  Future<void> _requestLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      setState(() {
        _locationPermissionGranted = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Разрешение на местоположение отклонено')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Карта',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1E88E5), // Голубой цвет из темы
        elevation: 4,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          // Проверка успешной инициализации карты
          if (_controller != null) {
            print('Карта успешно инициализирована');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ошибка инициализации карты')),
            );
          }
        },
        myLocationEnabled:
            _locationPermissionGranted, // Включаем только при разрешении
        myLocationButtonEnabled:
            _locationPermissionGranted, // Кнопка только при разрешении
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
