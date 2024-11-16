import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/ReportConfirmationPage.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final Location location = Location();
  LocationData? _currentLocation;
  String? _selectedStreet;
  final List<String> _streets = [
    'شارع حراء',
    'شارع قريش',
    'شارع صاري',
    'شارع الامير سعود الفيصل (الروضة سابقا)',
    'طريق الأمير محمد بن عبد العزيز (التحلية سابقا)',
    'شارع فلسطين',
    'طريق الملك عبد الله (ولي العهد سابقا)',
    'طريق مكة القديم',
  ];

  bool _loading = false;
  String? _error;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _currentLocation = _locationResult;
        _loading = false;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
  }

  Future<void> _submitReport() async {
    if (_selectedStreet == null && _currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى اختيار اسم الشارع أو تفعيل الموقع')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('reports').add({
      'streetName': _selectedStreet ?? 'موقع مباشر',
      'latitude': _currentLocation?.latitude,
      'longitude': _currentLocation?.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportConfirmationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إنشاء بلاغ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('اسم الشارع', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text('اختر اسم الشارع'),
              value: _selectedStreet,
              onChanged: (value) {
                setState(() {
                  _selectedStreet = value;
                  _currentLocation = null; // إلغاء الموقع إذا تم اختيار شارع
                });
              },
              items: _streets.map((street) {
                return DropdownMenuItem<String>(
                  value: street,
                  child: Text(street),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _getCurrentLocation,
              child: Text('أو اخذ موقعك المباشر'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReport,
              child: Text('إرسال'),
            ),
            SizedBox(height: 20),
            GetLocationWidget(), // إضافة GetLocationWidget هنا
          ],
        ),
      ),
    );
  }
}

class GetLocationWidget extends StatefulWidget {
  const GetLocationWidget({Key? key}) : super(key: key);

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocationWidget> {
  final Location location = Location();

  bool _loading = false;

  LocationData? _location;
  String? _error;

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
        _loading = false;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Location: ' + (_error ?? '${_location ?? "unknown"}'),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          children: <Widget>[
            ElevatedButton(
              child: _loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Get'),
              onPressed: _getLocation,
            )
          ],
        ),
      ],
    );
  }
}
