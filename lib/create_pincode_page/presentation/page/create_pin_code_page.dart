import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model_view/create_pin_code_vm.dart';
import '../widgets/create_pin_code_view.dart';

final pinNotifier = ChangeNotifierProvider((ref) => CreatePinCodeVM());

class CreatePinCodePage extends ConsumerStatefulWidget {
  const CreatePinCodePage({super.key});

  @override
  ConsumerState<CreatePinCodePage> createState() => _CreatePinCodePageState();
}

class _CreatePinCodePageState extends ConsumerState<CreatePinCodePage> {
  @override
  void initState() {
    super.initState();
    ref.read(pinNotifier).readPinCode();
    ref.read(pinNotifier).readConfirmCode();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(pinNotifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ref.read(pinNotifier).checkConfirm.isEmpty &&
              ref.read(pinNotifier).storeCode.isNotEmpty
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 24),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          ref.read(pinNotifier).onTapBackButton();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              leadingWidth: 100,
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Text(
            ref.read(pinNotifier).storeCode.isEmpty
                ? 'Set PIN'
                : (ref.read(pinNotifier).checkConfirm.isEmpty
                    ? 'Verify PIN'
                    : 'Enter PIN'),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 50),
          Container(
            height: 16,
            width: 140,
            alignment: Alignment.center,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: index < ref.read(pinNotifier).code.length
                      ? Colors.green
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 40,
            child: (ref.read(pinNotifier).incorrect)
                ? Text(
                    'Введен неправильный PIN,\nпопробуйте еше раз',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  )
                : const SizedBox.shrink(),
          ),
          const Spacer(),
          Container(
            height: 280,
            child: GridView.count(
              childAspectRatio: 1.8,
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(12, (index) {
                return index == 11
                    ? const DeleteButton()
                    : NumberButton(index: index);
              }),
            ),
          )
        ],
      ),
    );
  }
}
