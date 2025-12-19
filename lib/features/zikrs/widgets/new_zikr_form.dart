import 'package:dhikras/features/zikrs/models/new_zikr_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewZikr extends StatefulWidget {
  const NewZikr({super.key, required this.onAddZikr});
  final void Function(Items zikr) onAddZikr;

  @override
  State<NewZikr> createState() => _NewZikrState();
}

class _NewZikrState extends State<NewZikr> {
  TextEditingController amountController = TextEditingController();
  TextEditingController editingController = TextEditingController();
  TextEditingController translateController = TextEditingController();

  void submitZikrData() {
    final enteredAmount = int.tryParse(amountController.text);

    if (enteredAmount == null) {
      return;
    }
    widget.onAddZikr(
      Items(
        counterKey: "new_zikr_${DateTime.now().millisecondsSinceEpoch}",
        amount: enteredAmount,
        transcription: editingController.text,
        translation: translateController.text, 
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0).h,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                children: [
                  SizedBox(
                    height: 120.h,
                    child: TextField(
                      controller: amountController,
                      keyboardType:
                          TextInputType.number, 
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: '33',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 40.h,
                          horizontal: 24.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 20.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('Number of repetitions'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                children: [
                  SizedBox(
                    height: 120.h,
                    child: TextField(
                      controller: editingController,
                      decoration: InputDecoration(
                        hintText: 'Allahuma...',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 40.h,
                          horizontal: 24.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 20.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('Transcription'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                children: [
                  SizedBox(
                    height: 150.h,
                    child: TextField(
                      controller: translateController,
                      decoration: InputDecoration(
                        hintText: 'Once...',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 40.h,
                          horizontal: 24.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 20.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('Translation of dhikr'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 350.w,
              child: ElevatedButton(
                onPressed: () {
                  submitZikrData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
