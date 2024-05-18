import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trial_or_experiments/main.dart';
import '../page/create_pin_code_page.dart';

class NumberButton extends ConsumerWidget {
  final int index;

  const NumberButton({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) => GestureDetector(
        onTap: () {
          if (index != 9) {
            ref.read(pinNotifier).onTabFunction(index);
            ref.read(pinNotifier).storePinCode(context);
            if (ref.read(pinNotifier).isTrue) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const MyHomePage(title: "MyHomePage")),
                  (route) => false);
            }
          } else {
            ref.read(pinNotifier).onTapCEButton();
          }
        },
        child: Container(
          alignment: Alignment.center,
          // height: 70,
          // width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: index != ref.read(pinNotifier).topIndex
                  ? Colors.grey.shade300
                  : Colors.green,
              width: 0.5,
            ),
          ),
          child: Text(
            ref.read(pinNotifier).numbers[index],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      );
}

class DeleteButton extends ConsumerWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(pinNotifier);
    return GestureDetector(
      onTap: () {
        ref.read(pinNotifier).deleteButton();
      },
      child: Container(
        // height: 70,
        // width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.backspace_outlined,
          size: 25,
          color: Colors.green,
        ),
      ),
    );
  }
}
