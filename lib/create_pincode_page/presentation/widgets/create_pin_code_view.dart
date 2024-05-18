import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trial_or_experiments/images.dart';
import 'package:trial_or_experiments/main.dart';
import "package:flutter_svg/svg.dart";

import '../../model_view/create_pin_code_vm.dart';

class NumberButton extends ConsumerWidget {
  final int index;

  const NumberButton({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CreatePinCodeVM con = ref.read(pinCodeVM);
    return MaterialButton(
      onPressed: () {
        con.onTabFunction(index);
        con.storePinCode(context);
        if (con.isTrue) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (c) => const MyHomePage(title: "MyHomePage"),
            ),
            (route) => false,
          );
        }
      },
      color: Colors.white,
      shape: Border.all(
        color: const Color.fromRGBO(234, 234, 234, 1),
        width: 0.4,
      ),
      child: Text(
        con.numbers[index],
        style: const TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final SvgPicture icon;
  final VoidCallback onPressed;
  const Button({
    required this.icon,
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      shape: Border.all(color: Colors.grey.shade300, width: 0.5),
      child: icon,
    );
  }
}

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Button(
      icon: AppImages.deleteIcon,
      onPressed: onPressed,
    );
  }
}

class FaceIdButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FaceIdButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Button(
      icon: AppImages.faceId,
      onPressed: onPressed,
    );
  }
}

class UnderlinedText extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  const UnderlinedText({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        child,
        style: const TextStyle(
          color: Color.fromRGBO(73, 73, 73, 1),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
