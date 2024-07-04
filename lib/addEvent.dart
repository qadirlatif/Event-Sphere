import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class EventScreen extends StatefulWidget {
  EventScreen({super.key, required this.id});
  int id;

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  File? _image;
  final picker = ImagePicker();
  final _eventNameController = TextEditingController();
  final _eventVenueController = TextEditingController();
  final _eventCityController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _addEvent() async {
    if (_image == null || _selectedDate == null || _selectedTime == null) {
      // Display an alert or message to the user
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final dateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://eventsphere.somee.com/Society/AddEvent'),
    );

    request.fields['EventName'] = _eventNameController.text;
    request.fields['EventDateandTime'] = dateTime.toIso8601String();
    request.fields['EventVenue'] = _eventVenueController.text;
    request.fields['EventCity'] = _eventCityController.text;
    request.fields['SocietyID'] = widget.id.toString();

    final mimeTypeData =
        lookupMimeType(_image!.path, headerBytes: [0xFF, 0xD8])?.split('/');

    if (mimeTypeData != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'EventIcon',
          _image!.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );
    }

    final response = await request.send();

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      print('Event added successfully');
      // Clear fields
      setState(() {
        _eventNameController.clear();
        _eventVenueController.clear();
        _eventCityController.clear();
        _image = null;
        _selectedDate = null;
        _selectedTime = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event added successfully')),
      );
    } else {
      print('Failed to add event');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add event')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromRGBO(56, 89, 108, 0.7),
                  Color.fromRGBO(56, 89, 108, 1.0)
                ],
              ),
            ),
          ),
          title: Text('Add Event'),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Community Name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: getImage,
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 50)
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: _selectedDate == null
                        ? 'Event Date'
                        : DateFormat.yMd().format(_selectedDate!),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: _selectedTime == null
                        ? 'Event Time'
                        : _selectedTime!.format(context),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _eventVenueController,
              decoration: const InputDecoration(
                labelText: 'Event Venue',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _eventCityController,
              decoration: InputDecoration(
                labelText: 'Event City',
                border: OutlineInputBorder(),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            GestureDetector(
              onTap: _addEvent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromRGBO(224, 194, 157, 1),
                      Color.fromRGBO(194, 155, 110, 1)
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
