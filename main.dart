import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffebdfdf),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Length';
  double _inputValue = 0.0;
  double _convertedValue = 0.0;

  final Map<String, Map<String, double>> _conversionRates = {
    'Length': {
      'Meters to Kilometers': 0.001,
      'Kilometers to Meters': 1000.0,
      'Centimeters to Meters': 0.01,
      'Meters to Centimeters': 100.0,
    },
    'Weight': {
      'Kilograms to Grams': 1000.0,
      'Grams to Kilograms': 0.001,
      'Pounds to Kilograms': 0.453592,
      'Kilograms to Pounds': 2.20462,
    },
    'Temperature': {
      'Celsius to Fahrenheit': 1.8,
      'Fahrenheit to Celsius': 0.555556,
    },
  };

  String _selectedConversion = 'Meters to Kilometers';

  void _convert() {
    double result;
    if (_selectedCategory == 'Length' || _selectedCategory == 'Weight') {
      result = _inputValue *
          _conversionRates[_selectedCategory]![_selectedConversion]!;
    } else if (_selectedCategory == 'Temperature') {
      if (_selectedConversion == 'Celsius to Fahrenheit') {
        result = (_inputValue * 1.8) + 32;
      } else {
        result = (_inputValue - 32) * 0.555556;
      }
    } else {
      result = 0.0;
    }
    setState(() {
      _convertedValue = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Unit Converter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff910606),
            ),
          ),
          backgroundColor: Color(0xffa7a4a4),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: _selectedCategory,
                items: _conversionRates.keys.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    _selectedConversion =
                        _conversionRates[_selectedCategory]!.keys.first;
                    _inputValue = 0.0;
                    _convertedValue = 0.0;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Input Value'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _inputValue = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              DropdownButton<String>(
                value: _selectedConversion,
                items: _conversionRates[_selectedCategory]!
                    .keys
                    .map((String conversion) {
                  return DropdownMenuItem<String>(
                    value: conversion,
                    child: Text(conversion),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedConversion = newValue!;
                    _convertedValue = 0.0; // Reset converted value
                  });
                },
              ),
              ElevatedButton(
                onPressed: _convert,
                child: Text('Convert'),
              ),
              SizedBox(height: 20),
              Text(
                'Converted Value: $_convertedValue',
              )
            ],
          ),
        ));
  }
}