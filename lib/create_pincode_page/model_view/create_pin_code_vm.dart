import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AutoDisposeChangeNotifierProvider<CreatePinCodeVM> pinCodeVM =
    ChangeNotifierProvider.autoDispose<CreatePinCodeVM>(
        (ChangeNotifierProviderRef<CreatePinCodeVM> ref) => CreatePinCodeVM());

class CreatePinCodeVM extends ChangeNotifier {
  List<String> numbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '',
    '0',
    '',
  ];
  String code = '';
  String storeCode = '';
  bool isTrue = false;
  final storage = const FlutterSecureStorage();
  String checkConfirm = '';
  bool incorrect = false;
  int? topIndex;

  void onTabFunction(int index) {
    if (code.length != 4) {
      code = code + numbers[index];
      topIndex = index;
      notifyListeners();
    } else {}
  }

  Future<void> storePinCode(BuildContext context) async {
    if (storeCode.isEmpty && checkConfirm.isEmpty && code.length == 4) {
      await writePinCode();
      await Future.delayed(const Duration(milliseconds: 100), () {
        code = '';
        notifyListeners();
      });
      await readPinCode();
      notifyListeners();
    }

    if (storeCode.isNotEmpty &&
        checkConfirm.isEmpty &&
        code.length == 4 &&
        code == storeCode) {
      isTrue = true;
      notifyListeners();
      await writeConfirmCode();
    } else if (code.length == 4 && checkConfirm.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 100), () {
        code = '';
        notifyListeners();
      });
    }

    if (code == storeCode && checkConfirm == 'true' && code.length == 4) {
      isTrue = true;
      notifyListeners();
    } else if (code.length == 4 &&
        code != storeCode &&
        checkConfirm == "true") {
      incorrect = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1), () {
        incorrect = false;
        code = '';
        notifyListeners();
      });
    }
  }

  void onTapBackButton() {
    storeCode = '';
    notifyListeners();
  }

  Future<void> readPinCode() async {
    storeCode = (await storage.read(key: 'PIN_CODE')) ?? '';
    notifyListeners();
  }

  Future<void> readConfirmCode() async {
    checkConfirm = (await storage.read(key: 'CONFIRM_CODE')) ?? '';
    notifyListeners();
  }

  Future<void> writePinCode() async {
    await storage.write(key: 'PIN_CODE', value: code);
  }

  Future<void> writeConfirmCode() async {
    await storage.write(key: 'CONFIRM_CODE', value: 'true');
  }

  void deleteButton() {
    if (code.isNotEmpty) {
      code = code.replaceRange(code.length - 1, code.length, '');
      notifyListeners();
    }
  }
}
