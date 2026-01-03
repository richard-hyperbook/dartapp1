//import 'package:dartapp1/dartapp1.dart' as dartapp1;

// void main(List<String> arguments) {
  // print('Hello world: ${dartapp1.calculate()}!');
// }
import 'package:dart_appwrite/dart_appwrite.dart';

var client = Client();

Future<void> main() async {
  client
    .setEndpoint("https://fra.cloud.appwrite.io/v1")
    .setProject("decproject")
    // .setKey("standard_fc72951c2d86efd5a5438286217bf05b70d0dd46d1a79b6c5ef5973576befd4bcb15ac5fd5a258714a027f249deb8a918499dd0c3d633c14c0bb08abfdb7c05d876de573abf59b1590e05c509bc7e116b3f0962c9b32a278631deadb887c135e5022e65110b8d3c31f81149e8a832ea77fe934df259aeff9c2819b2c6e89fa0e");
    .setKey('standard_38f7ed6094ee93248ff7991c76e63f79b21f52a96921a13daceff4e09550d67d5f9711c65f6ca6aed4bb19f2e26b6fee44da4e5f2097214be20bf404f5a69b5f27a7092061d693ca7cb0b64ceab4abc0eb498e8c2ef572372ea2d2fbdca4e238fb13195fefe7d31f43da17e4b1b5462c55099b944f408d6cdfbb2f84f713090c');

var databases;
var todoDatabase;
var todoTable;

 var tablesDB;

   String dbId = '6956b8e60eac43d7ce4e';
  String tableId = 'table1';

Future<void> prepareDatabase() async {
  tablesDB = TablesDB(client);

   todoDatabase = await tablesDB.create(
     databaseId: ID.unique(), 
     name: 'TodosDB3'
   );

   todoTable = await tablesDB.createTable(
     databaseId: todoDatabase.$id, 
     tableId: ID.unique(), 
     name: 'Todos23'
   );

  dbId = todoDatabase.$id;
  tableId = todoTable.$id;

  await tablesDB.createStringColumn(
    databaseId: dbId,
    tableId: tableId,
    key: 'title',
    size: 255,
    xrequired: true
  );

  await tablesDB.createStringColumn(
    databaseId: dbId,
    tableId: tableId,
    key: 'description',
    size: 255,
    xrequired: false,
    xdefault: 'This is a test description'
  );

  await tablesDB.createBooleanColumn(
    databaseId: dbId,
    tableId: tableId,
    key: 'isComplete',
    xrequired: true
  );
}

Future<void> seedDatabase() async {
  var testTodo1 = {
    'title': 'Buy apples',
    'description': 'At least 2KGs',
    'isComplete': true
  };

  var testTodo2 = {
    'title': 'Wash the apples',
    'isComplete': true
  };

  var testTodo3 = {
    'title': 'Cut the apples',
    'description': 'Don\'t forget to pack them in a box',
    'isComplete': false
  };

  await tablesDB.createRow(
    databaseId: dbId,
    tableId: tableId,
    rowId: ID.unique(),
    data: testTodo1
  );

  await tablesDB.createRow(
    databaseId: dbId,
    tableId: tableId,
    rowId: ID.unique(),
    data: testTodo2
  );

  await tablesDB.createRow(
    databaseId: dbId,
    tableId: tableId,
    rowId: ID.unique(),
    data: testTodo3
  );
}

Future<void> getTodos() async {
  var todos = await tablesDB.listRows(
    databaseId: dbId, 
    tableId: tableId
  );

  // todos.forEach((todo) {
    //  print('Title: ${todo.data['title']}\nDescription: ${todo.data['description']}\nIs Todo Complete: ${todo.data['isComplete']}\n\n');
  //  });
  print(todos.rows);
  for(var r in todos.rows){
    print(r.data);
  }
}

await prepareDatabase();

Users users = Users(client);

var result = await users.createSession( userId: '6954ed3100375342d5a1', );

    await Future.delayed(const Duration(seconds: 1));
    await seedDatabase();
    await getTodos();

}
