import 'package:flutter/material.dart';
import 'add.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Map<String, dynamic>> tasks = [
    {"task": "Study Flutter", "date": "Today", "done": false},
    {"task": "Finish Math Homework", "date": "Tomorrow", "done": false},
    {"task": "Go to Gym", "date": "Friday", "done": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 50),

            Text(
              "Today's Tasks",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      taskCard(
                        tasks[index]["task"],
                        tasks[index]["date"],
                        tasks[index]["done"],
                        index,
                      ),
                      SizedBox(height: 15),
                    ],
                  );
                },
              ),
            ),

            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddScreen()),
                );

                if (result != null) {
                  setState(() {
                    tasks.add({
                      "task": result["task"],
                      "date": result["date"],
                      "done": false,
                    });
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Add New Task",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget taskCard(String title, String date, bool done, int index) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: done ? Colors.green.shade100 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  decoration: done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              SizedBox(height: 5),
              Text(date, style: TextStyle(color: Colors.grey)),
            ],
          ),

          IconButton(
            icon: Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked,
              color: done ? Colors.green : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                tasks[index]["done"] = !tasks[index]["done"];
              });
            },
          ),
        ],
      ),
    );
  }
}
