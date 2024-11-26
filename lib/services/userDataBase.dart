import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDataBase{
   static Database? database;
  Future initializeDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'user_table.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_table(company_id TEXT,job_id TEXT,name TEXT,email TEXT,phone TEXT)'
            );
      },
      version: 1,


  
    );
  }

  Future<void> insertValue(
    {
      required String companyId,
      required String jobId,
      required String name,
      required String email,
      required String phone,
    })async{
    var values = {
      'company_id':companyId,
      'job_id':jobId,
      'name':name,
      'email':email,
      'phone':phone,
    };
    try{
      await database?.insert('user_table',values,);

    }catch(e){
      print(e);

    }

  }

  Future retrieveValue() async{
    var valueMap = await database?.query('user_table');
    print('-------------$valueMap');
    return valueMap;
  }

}