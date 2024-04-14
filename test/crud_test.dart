import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/controller/helper/dioHelper.dart';

void main() async {

  test('Fetch resource with status 200', () async {
    await DioHelper.init();

    final response = await DioHelper.getDataAPI(url: 'todo');

    expect(response.statusCode, 200);
  });
  test('add new todo 200', () async {
    await DioHelper.init();

    await DioHelper.postDataAPI(
        url: 'todo/add',
        data: {"todo": "a2aa", "completed": false, "userId": 5}).then((value) {
      expect(value.statusCode, 200);
      expect(value.data, contains('todo'));
      expect(value.data['todo'], isA<String>());
    }).catchError((e) {
      expect(e.response.statusCode, 200);
    });
  });
  test('add new todo 400', () async {
    await DioHelper.init();

    await DioHelper.postDataAPI(url: 'todo/add', data: {
      "todo": "a2aa",
      "completed": false,
    }).then((value) => expect(value.statusCode, 400)).catchError((e) {
      expect(e.response.statusCode, 400);
    });
  });
  test('add new todo 404', () async {
    await DioHelper.init();

    await DioHelper.postDataAPI(url: 'todo/addTask', data: {
      "todo": "a2aa",
      "completed": false,
    }).then((value) => expect(value.statusCode, 404)).catchError((e) {
      expect(e.response.statusCode, 404);
    });
  });
}
