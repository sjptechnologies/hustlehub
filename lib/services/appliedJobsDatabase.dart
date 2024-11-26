import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppliedJobsDatabase {
  static Database? database;
  Future initializeDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'applied_jobs.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE applied_jobs(company_id TEXT,job_title TEXT,company_name TEXT,job_location TEXT,salary TEXT,job_type TEXT,opportunity_type TEXT, date TEXT,experience INTEGER,application_count INTEGER,job_time TEXT,perks TEXT, preference TEXT, description TEXT,openings INTEGER, skill TEXT)'
            );
      },
      version: 1,
    );
  }

  Future<void> insertValue(
    {
      required String companyId,
      required String jobTime,
      required String opportunity_type,
      required List<dynamic> perks,
      required List<dynamic> preference,
      required List<dynamic> description,
      required int openings,
      required String skill,
      required String title,
      required String companyName,
      required String location,
      required String salary,
      required String jobType,
      required String oppurtunityType,
      required String dateOfPost,
      required int experience,
      required int applicationCount,
    })async{
    var values = {
      'company_id':companyId,
      'opportunity_type':opportunity_type,
      'job_title':title,
      'salary':salary,
      'job_location':location,
      'application_count':applicationCount,
      'date':dateOfPost,
      'job_type':jobType,
      'job_time':jobTime,
      'perks':jsonEncode(perks),
      'preference':jsonEncode(preference),
      'description':jsonEncode(description),
      'experience':experience,
      'openings':openings,
      'skill':skill,
      'company_name':companyName,
    };
    try{
      await database?.insert('applied_jobs',values,);

    }catch(e){
      print('------------$e---------');

    }

  }

  Future retrieveValue() async{
    var valueMap = await database?.query('applied_jobs');
     if (valueMap != null) {
    valueMap = valueMap.map((row) {
      return {
        ...row,
        'perks': jsonDecode(row['perks'] as String), // Decode JSON string to List
        'preference': jsonDecode(row['preference'] as String), // Decode JSON string to List
        'description': jsonDecode(row['description'] as String), // Decode JSON string to List
      };
    }).toList();
  }
    return valueMap;
  }

  Future<void> deleteValue({
     required String companyId,
      required String jobTime,
      required String opportunity_type,
      required int openings,
      required String skill,
      required String title,
      required String companyName,
      required String location,
      required String salary,
      required String jobType,
      required String dateOfPost,
      required int experience,
      required int applicationCount,
  })async{
    await database?.delete('applied_jobs',where: 'company_id =? AND job_title =? AND company_name =? AND job_location =? AND salary =? AND job_type =? AND opportunity_type =? AND date =? AND experience =? AND application_count =? AND job_time =?  AND openings =? AND skill =? ',
    whereArgs: [companyId,title,companyName,location,salary,jobType,opportunity_type,dateOfPost,experience,applicationCount,jobTime,openings,skill]
    );
  }


}