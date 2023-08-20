import 'package:cart_app_viva/modals/modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  //todo: initialize db
  static Database? db;

  Future initDB() async {
    String dbLocation = await getDatabasesPath();

    String path = join(dbLocation, "data.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            "CREATE TABLE Product(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,description TEXT NOT NULL,price NUMERIC NOT NULL,quantity NUMERIC NOT NULL);";
        await db.execute(query);
      },
    );
  }

  Future<int> insertCategory({required Product data}) async {
    await initDB();

    String query = "INSERT INTO Product(id,name,description,price,quantity) VALUES(?,?,?,?,?);";
    List args = [
      data.id,
      data.name,
      data.description,
      data.price,
      data.quantity,
    ];
    int res = await db!.rawInsert(query, args); //return pk => inserted record's id

    return res;
  }

  Future<List<Product>> fetchALlCategories()async{
    await initDB();
    String query = "SELECT * FROM Product ORDER BY RANDOM() LIMIT 10;";

    List<Map<String, dynamic>> res =await db!.rawQuery(query);  //List<Map<String, dynamic>>

    List<Product> allproduct =  res.map((e) => Product.fromMap(data: e)).toList();
    return allproduct;
  }


  Future<int>deleteCategory({required int id})async{
    await initDB();
    String query = "DELETE FROM Product WHERE id=?;";
    List args = [id];
    int res = await db!.rawDelete(query,args);
    return res;
  }



  Future<int> updateCategory(Product product) async {
    await initDB();

    String query = "UPDATE products SET quantity = ? WHERE id = ?;";
    List args = [product.id];
    int res = await db!.rawUpdate(query, args); //returns total no. of updated records' count
    return res;
  }


}
