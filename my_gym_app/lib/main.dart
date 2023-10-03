import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
//import 'package:sqflite_common_ffi/lib/sqflite_ffi.dart' as sqflite_ffi;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : workouts = [], super(key: key);
  List<Workout> workouts;
  

  
  
  

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
  // Database of Workouts are created here
  //sqflite_ffi.sqfliteFfiInit();
  
  //final databaseFactory = databaseFactoryFfi;
  final workoutDatabase = WorkoutDatabase();

  List<Workout> workouts = [];
  int count = 0;
  

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

            // The following code creates a date and time picker
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
      
          // The following code creates the text fields for the workouts
      
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
                child: TextField(controller: _skullcrush, decoration: InputDecoration(hintText: "Number of Reps", labelText: "Number of Reps")),
              ),
            ),

            

           

            // The following code creates the add workout button
            
            Builder(builder: (context) => ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black26)),
              onPressed: () async {
                
                // Workout object is created based on the data written
                final workout = Workout(benchpress: _benchpress.text, inclinepress: _inclinepress.text, chestflies: _chestflies.text, dips: _dips.text, tripull: _tripulldown.text, skullcrush: _skullcrush.text);

                // Insert the workout to the DB here

                workoutDatabase.insertWorkout(workout);
                workouts = await workoutDatabase.getWorkouts();


                //workouts.add(workout);


                  
                 // Add the new workout to the list
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutPage(workouts: workouts, count: count,)),
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




// The following class creates workout objects
class Workout {
  final int? id;
  final String benchpress;
  final String inclinepress;
  final String chestflies;
  final String dips;
  final String tripull;
  final String skullcrush;

  Workout({
    this.id,
    required this.benchpress,
    required this.inclinepress,
    required this.chestflies,
    required this.dips,
    required this.tripull,
    required this.skullcrush,
  });

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'benchpress': benchpress,
      'inclinepress': inclinepress,
      'chestflies': chestflies,
      'dips': dips,
      'tripull': tripull,
      'skullcrush': skullcrush,
    };
  }

    static Workout fromMap(Map<String, dynamic> map) {
    return Workout(
      //id: map['id'],
      benchpress: map['benchpress'],
      inclinepress: map['inclinepress'],
      chestflies: map['chestflies'],
      dips: map['dips'],
      tripull: map['tripull'],
      skullcrush: map['skullcrush'],
    );
  }

  
/*
  @override
  String toString() {
    return 'Workout(benchpress: $benchpress, inclinepress: $inclinepress, chestflies: $chestflies, dips: $dips, tripull: $tripull, skullcrush: $skullcrush)';
  } */

}



// Database creation

class WorkoutDatabase {
  static final _databaseName = 'workouts.db';
  static final _databaseVersion = 1;

  static final table = 'workouts';

  static final columnId = '_id';
  static final columnBenchPress = 'benchpress';
  static final columnInclinePress = 'inclinepress';
  static final columnChestFlies = 'chestflies';
  static final columnDips = 'dips';
  static final columnTriPull = 'tripull';
  static final columnSkullCrush = 'skullcrush';

  static Database? _database;


  // The following code checks if the database has been created, if not it creates a database

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }


  // Database initialisation
  Future<Database> _initDatabase() async {
    sqflite_ffi.sqfliteFfiInit();
    sqflite_ffi.databaseFactory = sqflite_ffi.databaseFactoryFfi;
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Note : Primary key for ID is being autogenerated

    Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnBenchPress TEXT NOT NULL,
        $columnInclinePress TEXT NOT NULL,
        $columnChestFlies TEXT NOT NULL,
        $columnDips TEXT NOT NULL,
        $columnTriPull TEXT NOT NULL,
        $columnSkullCrush TEXT NOT NULL
      )
    ''');
  }

    // This code creates the workout
    // toMap allows the code to direclty add the values of each workout object
    Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    return await db.insert(table, workout.toMap());
  }

  // To view workouts, call this function -

    Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) => Workout.fromMap(maps[i]));
  }

  // To update or edit workouts - 

  Future<int> updateWorkout(Workout workout) async {
    final db = await database;
    return await db.update(table, workout.toMap(), where: '$columnId = ?', whereArgs: [workout.id]);
  }


  // To delete workouts -

  Future<int> deleteWorkout(int id) async {
    final db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}




/*
 Doc1 
I want the data to be stored on local storage that the app can access so `
that the memory of previous workouts presist
*/



class WorkoutPage extends StatelessWidget {
  var workouts;

   WorkoutPage({Key? key, required this.workouts, required count})
      : super(key: key);

      // Workout boxes are created here, there for we need to extract the workout
      // items from the list of workouts over here


      // The following function creates workout boxes
      Widget buildWorkoutWidget(Workout workout, int index) {
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
                      Text('Workout number ${index + 1}', style: TextStyle(decoration: TextDecoration.underline)),
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







// The following function creates the new page
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
      ),

      // Call the database and turn into list to apply the Tile builder function
      //workoutDatabase.getWorkouts()


      
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stored workouts'),
        ),
        body: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (BuildContext context, int index) {
            return buildWorkoutWidget(workouts[index], index);
          },
        )
      ),
    );
  }
}




