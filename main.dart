import 'package:flutter/material.dart';


// Use MyClass in your code

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : workouts = [], super(key: key);
  final List<Workout> workouts;
  

  

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
      ),
      child: MaterialApp(
        home: MainApp(),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);
  final List<Workout> workouts = [];
  
  
  

  @override
  Widget build(BuildContext context) {

    final TextEditingController _benchpress = TextEditingController();
    final TextEditingController _inclinepress = TextEditingController();
    final TextEditingController _chestflies= TextEditingController();
    final TextEditingController _dips = TextEditingController();
    final TextEditingController _tripulldown = TextEditingController();
    final TextEditingController _skullcrush = TextEditingController();

    return MaterialApp(
      title: 'Gym App',
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(title: Text('Gym App')),
      
      body: Center(
        child: Column(
          children : [ 
            SizedBox(height: 16,),

            
      
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    final dateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                    print(dateTime);
                  }
                }
              },
              child: const Text(
                "Choose a date and time",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black12,
                    ),
            ),
      
            
      
            Text("1. Bench Press : "),
      
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: _benchpress, decoration: InputDecoration(hintText: "Number of Reps")),
              ),
            ),
            
            
            Text("2. Incline Press : "),
      
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: _inclinepress, decoration: InputDecoration(hintText: "Number of Reps")),
              ),
            ),
      
            Text("3. Chest Flies : "),
      
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: _chestflies, decoration: InputDecoration(hintText: "Number of Reps")),
              ),
            ),                      
      
            Text("4. Dips : "),
      
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: _dips, decoration: InputDecoration(hintText: "Number of Reps")),
              ),
            ),
      
            Text("5. Tricep Pull Downs : "),
      
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: _tripulldown, decoration: InputDecoration(hintText: "Number of Reps")),
              ),
            ),
      
            Text("6. Skull Crushers : "),
      
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: _skullcrush, decoration: InputDecoration(hintText: "Number of Reps", labelText: "6. Skull Crushers")),
              ),
            ),

            Builder(builder: (context) => ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black26)),
              onPressed: () {
                final workout = Workout(benchpress: _benchpress.text, inclinepress: _inclinepress.text, chestflies: _chestflies.text, dips: _dips.text, tripull: _tripulldown.text, skullcrush: _skullcrush.text);
                workouts.add(workout); // Add the new workout to the list
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPage(workout: workout,)),
                );
              },
              child: Text('Add Workout'),
            ),)
      

      
          ]
        ),
      ),
    )
    );
  }
}


class Workout {
  final String benchpress;
  final String inclinepress;
  final String chestflies;
  final String dips;
  final String tripull;
  final String skullcrush;

  Workout({
    required this.benchpress,
    required this.inclinepress,
    required this.chestflies,
    required this.dips,
    required this.tripull,
    required this.skullcrush,
  });

  @override
  String toString() {
    return 'Workout(benchpress: $benchpress, inclinepress: $inclinepress, chestflies: $chestflies, dips: $dips, tripull: $tripull, skullcrush: $skullcrush)';
  }

}




class NewPage extends StatelessWidget {
  final workout;

  const NewPage({Key? key, required this.workout})
      : super(key: key);




      Widget buildWorkoutWidget(Workout workout) {
        return Center(
          child: Column(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Text('Workout'),
                      Text("${workout.benchpress} : Benchpress", textAlign: TextAlign.left),
                      Text("${workout.inclinepress} : Inclinepress", textAlign: TextAlign.right),
                      Text("${workout.chestflies} : Chest flies", textAlign: TextAlign.right),
                      Text("${workout.dips} : Dips", textAlign: TextAlign.left),
                      Text("${workout.tripull} : Tricep pulldowns", textAlign: TextAlign.left),
                      Text("${workout.skullcrush} : Skullcrushers", textAlign: TextAlign.left ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }




  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stored workouts'),
        ),
        body: buildWorkoutWidget(workout),
      ),
    );
  }
}








