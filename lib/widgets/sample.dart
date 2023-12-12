// This File is For Practice the code

import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Sample data
  List<String> originalData = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Elderberry"
  ];

  // Data to be displayed based on the filter
  List<String> filteredData = [];

  // Selected filter value
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    // Initially, show all data
    filteredData = List.from(originalData);
  }

  // Function to filter data based on the selected filter
  void filterData(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'All') {
        // Show all data
        filteredData = List.from(originalData);
      } else {
        // Filter data based on the selected category
        filteredData =
            originalData.where((item) => item.startsWith(filter)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Data Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // DropdownButton for selecting filter
            DropdownButton<String>(
              value: selectedFilter,
              onChanged: (String? newValue) {
                filterData(newValue!);
              },
              items: ['All', 'A', 'B', 'C', 'D', 'E']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Display filtered data
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredData[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
