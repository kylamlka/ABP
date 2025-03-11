import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp11_2());
}

class MyApp11_2 extends StatelessWidget {
  const MyApp11_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABP Minggu 11',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHomePage(title: 'ABP Minggu 11'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> data = [
    {
      "title": "Native App",
      "platform": "Android, iOS",
      "lang": "Java, Kotlin, Swift, C#",
      "color": Colors.red,
    },
    {
      "title": "Hybrid App",
      "platform": "Android, iOS, Web",
      "lang": "Javascript, Dart",
      "color": Colors.grey,
    },
  ];

  var titleInput = TextEditingController();
  var platInput = TextEditingController();
  var langInput = TextEditingController();
  List<String> colors = ['blue', 'green', 'yellow'];
  List<DropdownMenuItem<String>> ddItems = [];
  var colSelected;

  @override
  void initState() {
    super.initState();
    for (String col in colors) {
      ddItems.add(DropdownMenuItem(child: Text(col), value: col));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Detail"),
                        content: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]["title"],
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 28,
                                  ),
                                ),
                                Text(
                                  data[index]["platform"],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  data[index]["lang"],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: data[index]["color"],
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index]["title"],
                            style: TextStyle(color: Colors.blue, fontSize: 28),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          var snackBar = SnackBar(
            content: Text("Add new tech?"),
            action: SnackBarAction(
              label: 'Add',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text('Add New Tech'),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Tech Name',
                                  hintText: "Tech Name",
                                ),
                                controller: titleInput,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Platform',
                                  hintText: "Platform",
                                ),
                                controller: platInput,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Lang',
                                  hintText: "Lang",
                                ),
                                controller: langInput,
                              ),
                              DropdownButtonFormField(
                                items: ddItems,
                                onChanged: (val) {
                                  setState(() {
                                    colSelected = val;
                                  });
                                },
                              ),
                              ElevatedButton(
                                child: Text("Save"),
                                onPressed: () {
                                  if (colSelected == 'blue') {
                                    colSelected = Colors.blue;
                                  } else if (colSelected == 'green') {
                                    colSelected = Colors.green;
                                  } else if (colSelected == 'yellow') {
                                    colSelected = Colors.yellow;
                                  }
                                  setState(() {
                                    data.add({
                                      'title': titleInput.text,
                                      'platform': platInput.text,
                                      'lang': langInput.text,
                                      'color': colSelected,
                                    });
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
