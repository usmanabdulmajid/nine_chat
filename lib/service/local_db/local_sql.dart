import 'dart:io';
import 'dart:math';

import 'package:nine_chat/models/message.dart';
import 'package:nine_chat/models/chat.dart';
import 'package:nine_chat/service/local_db/local_db_contract.dart';
import 'package:nine_chat/utils/constants/db_consts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalSql implements ILocalDb {
  LocalSql._private();
  static final LocalSql _instace = LocalSql._private();
  static LocalSql get instance => _instace;

  Database? _database;
  Future<Database> get db async => _database ??= await _initializeDb();

  Future<Database> _initializeDb() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, 'nine_chat');
    var nineDb = openDatabase(path, version: 1, onCreate: _oncreate);
    return nineDb;
  }

  void _oncreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $messageTable (
      $mId Text,
      $editId Text
      $messageId Text,
      $content Text,
      $from Text,
      $to Text,
      $date Text,
    )''');

    await db.execute('''CREATE TABLE $chatTable (
      $cId Text,
      $chatId Text,
      $chatName Text,
      $imageUrl Text,
      $lastmessage Text,
    )
    ''');
  }

  @override
  Future<bool> deleteChats(List<String> chatId) async {
    final db = await this.db;
    int result =
        await db.delete(chatTable, where: '$chatId = ?', whereArgs: chatId);
    return result != 0;
  }

  @override
  Future<bool> deleteMessages(List<String> messageId) async {
    final db = await this.db;
    int result = await db.delete(messageTable,
        where: '$messageId = ?', whereArgs: messageId);
    return result != 0;
  }

  @override
  Future<List<Chat>> fetchChats() async {
    final db = await this.db;
    List<Chat> chats = [];
    List<Map<String, dynamic>> rawChats = await db.query(chatTable);
    chats = rawChats.map((chat) => Chat.fromJson(chat)).toList();
    return chats;
  }

  @override
  Future<List<Message>> fetchMessages(String chatId) async {
    final db = await this.db;
    List<Message> messages = [];
    List<Map<String, dynamic>> rawMessages =
        await db.query(messageTable, where: 'chatId = ?', whereArgs: [chatId]);
    messages = rawMessages.map((message) => Message.fromJson(message)).toList();
    return messages;
  }

  @override
  Future<bool> insertChats(List<Chat> chats) async {
    final db = await this.db;
    Batch batch = db.batch();
    for (Chat chat in chats) {
      batch.insert(chatTable, chat.toJson());
    }
    var result = await batch.commit(noResult: false, continueOnError: true);
    return result.isNotEmpty;
  }

  @override
  Future<bool> insertMessage(Message message) async {
    final db = await this.db;
    final result = await db.insert(messageTable, message.toJson());
    return result != 0;
  }

  @override
  Future<List<Chat>> searchChats(String chatName) async {
    final db = await this.db;
    List<Chat> searchedChats = [];
    List<Map<String, dynamic>> rawChats =
        await db.query(chatTable, where: 'chatName = ?', whereArgs: [chatName]);
    searchedChats = rawChats.map((chat) => Chat.fromJson(chat)).toList();
    return searchedChats;
  }

  @override
  Future<bool> updateMessage(Message message) async {
    final db = await this.db;
    final result = await db.update(messageTable, message.toJson(),
        where: 'messageId = ?', whereArgs: [message.id]);
    return result != 0;
  }

  @override
  Future<bool> insertMessages(List<Message> messages) async {
    final db = await this.db;
    Batch batch = db.batch();
    for (Message message in messages) {
      if (message.editId != null) {
        batch.update(messageTable, message.toJson(),
            where: 'messageId = ?', whereArgs: [message.editId]);
      } else {
        batch.insert(messageTable, message.toJson());
      }
    }
    var result = await batch.commit(noResult: false, continueOnError: true);
    return result.isNotEmpty;
  }

  @override
  Future<bool> insertChat(Chat chat) async {
    final db = await this.db;
    var result = await db.insert(chatTable, chat.toJson());
    return result != 0;
  }
}
