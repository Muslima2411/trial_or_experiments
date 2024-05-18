import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trial_or_experiments/images.dart';
import '../../model_view/create_pin_code_vm.dart';
import '../widgets/create_pin_code_view.dart';

class CreatePinCodePage extends ConsumerWidget {
  const CreatePinCodePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch<CreatePinCodeVM>(pinCodeVM);
    final CreatePinCodeVM con = ref.read(pinCodeVM);
    con.readPinCode();
    con.readConfirmCode();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "PIN-kod",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          size: 28,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 143),
        child: Column(
          children: [
            SizedBox(
              child: con.storeCode.isEmpty
                  ? AppImages.lockSetPin
                  : (con.checkConfirm.isEmpty
                      ? AppImages.lockVerifyPin
                      : AppImages.lockEnterPin),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              con.storeCode.isEmpty
                  ? "PIN-kodni o'rnating"
                  : (con.checkConfirm.isEmpty
                      ? "PIN-kodni takrorlang"
                      : "PIN-kodni kiriting"),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 35),
            Container(
              height: 16,
              width: 140,
              alignment: Alignment.center,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: index < con.code.length && !con.incorrect
                        ? const Color.fromRGBO(
                            0, 186, 119, 1) //rgba(0, 186, 119, 1)
                        : con.incorrect
                            ? const Color.fromRGBO(251, 75, 71, 1)
                            : const Color.fromRGBO(
                                223, 223, 223, 1), //rgba(223, 223, 223, 1)
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const Spacer(),
            UnderlinedText(onTap: () {}, child: "Parolni unutdingizmi?"),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              height: 286,
              child: GridView.count(
                childAspectRatio: 1.8,
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(12, (index) {
                  return index == 11
                      ? DeleteButton(
                          onPressed: () {},
                        )
                      : index == 9
                          ? FaceIdButton(onPressed: () {})
                          : NumberButton(index: index);
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
