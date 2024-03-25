import 'package:flutter/material.dart';

class AttendanceRecordScreen extends StatefulWidget {
  @override
  _AttendanceRecordScreenState createState() => _AttendanceRecordScreenState();
}

class _AttendanceRecordScreenState extends State<AttendanceRecordScreen> {
  String selectedMonth = 'Jan'; // Default month
  int selectedYear = DateTime.now().year; // Default year
  String selectedClass = 'Class A'; // Default class
  String selectedSortOption = 'Name'; // Default sort option
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<String> classes = ['Class A', 'Class B', 'Class C']; // Sample classes
  Map<String, dynamic> attendanceData = {}; // Sample data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Report'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: selectedMonth,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                        // Call function to fetch attendance data for the selected month, year, and class
                        fetchAttendanceData();
                      });
                    },
                    items: months.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<int>(
                    value: selectedYear,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                        // Call function to fetch attendance data for the selected month, year, and class
                        fetchAttendanceData();
                      });
                    },
                    items: List.generate(10, (index) {
                      return DropdownMenuItem<int>(
                        value: DateTime.now().year - index,
                        child: Text('${DateTime.now().year - index}'),
                      );
                    }),
                  ),
                  DropdownButton<String>(
                    value: selectedClass,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedClass = newValue!;
                        // Call function to fetch attendance data for the selected month, year, and class
                        fetchAttendanceData();
                      });
                    },
                    items: classes.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedSortOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSortOption = newValue!;
                        // Call function to sort attendance data
                        sortAttendanceData();
                      });
                    },
                    items: ['Name', 'Percentage'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (attendanceData.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attendance Report',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    // Display attendance data
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: attendanceData.length,
                      itemBuilder: (context, index) {
                        String studentName = attendanceData.keys.elementAt(index);
                        double attendancePercentage = attendanceData[studentName]['attendance_percentage_custom'];
                        return ListTile(
                          title: Text(studentName),
                          subtitle: Text('Attendance: $attendancePercentage%'),
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to fetch attendance data based on selected month, year, and class
  void fetchAttendanceData() {
    // Simulated data fetching process
    // Replace this with your actual data fetching logic
    setState(() {
      // Sample data
      attendanceData = {
        "Aarav1": {"attendance_percentage_custom": 25.0},
        "Agrim": {"attendance_percentage_custom": 50.0},
        "Akshita": {"attendance_percentage_custom": 25.0},
        "Ansh": {"attendance_percentage_custom": 0.0},
        "Atishay": {"attendance_percentage_custom": 0.0},
        "Daksh": {"attendance_percentage_custom": 0.0},
        "Pratishtha": {"attendance_percentage_custom": 50.0},
        "Priyanshi": {"attendance_percentage_custom": 75.0},
        "Rootviz": {"attendance_percentage_custom": 50.0},
        "Shrut": {"attendance_percentage_custom": 0.0},
        "Sweety": {"attendance_percentage_custom": 75.0}
      };
      // Sort data initially based on selected sort option
      sortAttendanceData();
    });
  }

  // Function to sort attendance data based on selected sort option
  void sortAttendanceData() {
    if (selectedSortOption == 'Name') {
      // Sort by name
      setState(() {
        attendanceData = Map.fromEntries(attendanceData.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
      });
    } else if (selectedSortOption == 'Percentage') {
      // Sort by percentage
      setState(() {
        attendanceData = Map.fromEntries(attendanceData.entries.toList()
          ..sort((a, b) => (b.value['attendance_percentage_custom'] as double)
              .compareTo(a.value['attendance_percentage_custom'] as double)));
      });
    }
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: AttendanceRecordScreen(),
//   ));
// }
