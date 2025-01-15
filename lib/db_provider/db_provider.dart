import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider extends State {
  static Database? _database;
  static final DBProvider db = DBProvider();
  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'booking.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      // Create CheckerProductDetails  Table
      await db.execute(
        "CREATE TABLE booking(id INTEGER PRIMARY KEY,name TEXT, phoneno TEXT, license TEXT,dropflightno TEXT,dropdate TEXT, droptime TEXT,pickflightno TEXT,pickdate TEXT, picktime TEXT,status INTEGER)",
      );

    });
  }
  insertbooking(
  String name,String phoneno,String license,String dropflightno,String dropdate, String droptime,String pickflightno,String pickdate,String picktime,int status) async {
    //await deleteVandetailsadata();
    final db = await database;
    final res = await db!.rawInsert(
        'INSERT INTO  booking(name,phoneno,license,dropflightno,dropdate, droptime,pickflightno,pickdate, picktime,status) VALUES("$name","$phoneno","$license","$dropflightno","$dropdate","$droptime","${pickflightno}","${pickdate}","$picktime",$status)');

    return res;
  }
  Future<List> getAllBooking() async {
    final db = await database;
    return await db!.rawQuery("SELECT id, name,phoneno,license,dropflightno,dropdate, droptime,pickflightno,pickdate, picktime,status FROM  booking");
  }
  Future<int> deletebooking(int id) async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM booking Where id=$id');

    return res;
  }
  Updatestatus(int id, int status) async {
    final db = await database;
    return db?.rawQuery(
        'UPDATE  booking SET status=$status Where id=$id');
  }
  Future<void> deleteallbooking() async {
    final db = await database;
     await db!.rawDelete('DELETE FROM booking');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
