import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabse {
  static Database? database;
  Future initializeDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'saved_jobs.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE saved_jobs(title TEXT,company_name TEXT,location TEXT,initial_salary TEXT,final_salary TEXT,job_type TEXT,opportunity_type TEXT, date_of_post TEXT,experience INTEGER,application_count INTEGER,is_saved INTEGER)'
            );
      },
      version: 1,


  
    );
  }

  Future<void> insertValue(
    {
      required String title,
      required String companyName,
      required String location,
      required String initialSalary,
      required String finalSalary,
      required String jobType,
      required String oppurtunityType,
      required String dateOfPost,
      required int experience,
      required int applicationCount,
      required bool isSaved,
    })async{
    var values = {
      'title':title,
      'company_name':companyName,
      'location':location,
      'initial_salary':initialSalary,
      'final_salary':finalSalary,
      'job_type':jobType,
      'opportunity_type':oppurtunityType,
      'date_of_post':dateOfPost,
      'experience':experience,
      'application_count':applicationCount,
      'is_saved':isSaved ? 1:0,
    };
    try{
      await database?.insert('saved_jobs',values,);

    }catch(e){
      print(e);

    }

  }

  Future retrieveValue() async{
    var valueMap = await database?.query('saved_jobs');
    return valueMap;
  }

 
Future deleteValue(
        {
      required String title,
      required String companyName,
      required String location,
      required String initialSalary,
      required String finalSalary,
      required String jobType,
      required String oppurtunityType,
      required String dateOfPost,
      required int experience,
      required int applicationCount,
    }
  ) async{
    await database?.delete('saved_jobs',where:'title =? AND company_name =? AND  location =? AND initial_salary =? AND final_salary =? AND job_type =? AND opportunity_type =? AND date_of_post =? AND experience =? AND application_count =?',
    whereArgs: [title,companyName,location,initialSalary,finalSalary,jobType,oppurtunityType,dateOfPost,experience,applicationCount]);

  }

  Future<bool> isJobSaved(String title, String companyName) async {
    final result = await database?.query(
      'saved_jobs',
      where: 'title = ? AND company_name = ?',
      whereArgs: [title, companyName],
    );
    return result!.isNotEmpty;
  }
}
