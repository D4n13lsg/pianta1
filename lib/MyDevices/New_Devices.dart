import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//esto es un device
class NewDevice extends StatefulWidget {
  const NewDevice({Key? key}) : super(key: key);

  @override
  _NewDeviceState createState() => _NewDeviceState();
}

class _NewDeviceState extends State<NewDevice> {
  final _formKey = GlobalKey<FormState>();
  final _deviceNameController = TextEditingController();
  final _locationController = TextEditingController();
  String? _selectedTemplate;
  List<dynamic> _templates = [];
  String? _deviceName;
  String? _location;

  @override
  void initState() {
    super.initState();
    _getTemplates();
  }

  Future<void> _getTemplates() async {
    final url = Uri.parse('http://127.0.0.1:8000/user/template/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _templates = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load templates');
    }
  }

  @override
  void dispose() {
    _deviceNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveDevice() async {
    if (_deviceNameController.text.isNotEmpty) {
      final url = Uri.parse('http://127.0.0.1:8000/user/devices/');

      String? templateId;

      if (_selectedTemplate != null) {
        // Busca el template seleccionado en la lista de templates para obtener su ID
        final selectedTemplate = _templates.firstWhere((
            template) => template['name'] == _selectedTemplate);
        templateId = selectedTemplate['id'].toString();
      }

      final response = await http.post(url, body: {
        'name': _deviceNameController.text,
        'template': templateId,
        'location': _locationController.text,
      });

      if (response.statusCode == 201) {
        setState(() {
          _deviceName = _deviceNameController.text;
          _location = _locationController.text;
        });
        Navigator.of(context).pop(true);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to save device'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_deviceName ?? 'New Device'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Muestra un cuadro de diálogo para ingresar la ubicación
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final locationController = TextEditingController();

                  return AlertDialog(
                    title: const Text('Enter Location'),
                    content: TextFormField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final location = locationController.text;
                          // Guarda la ubicación en la API o en una variable de estado
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _deviceNameController,
                decoration: const InputDecoration(
                  labelText: 'Device Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a device name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Device Template',
                  border: OutlineInputBorder(),
                ),
                value: _selectedTemplate,
                items: _templates
                    .map((template) =>
                    DropdownMenuItem<String>(
                      value: template['name'],
                      child: Text(template['name']),
                    ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTemplate = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a device template';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveDevice();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
