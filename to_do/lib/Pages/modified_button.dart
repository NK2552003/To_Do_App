import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/provider/radio_provider.dart';

class ModifiedRadioButton extends ConsumerWidget {
  const ModifiedRadioButton(
      {super.key,
      required this.title,
      required this.categoryColor,
      required this.val,
      required this.onChangeValue});

  final String title;
  final Color categoryColor;
  final int val;
  final VoidCallback onChangeValue;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioCategory = ref.watch(radioProvider);
    return Theme(
        data: ThemeData(unselectedWidgetColor: categoryColor),
        child: RadioListTile(
            activeColor: categoryColor,
            contentPadding: EdgeInsets.zero,
            title: Transform.translate(
              offset: const Offset(-22, 1),
              child: Text(title,
                  style: TextStyle(
                      color: categoryColor, fontWeight: FontWeight.w700)),
            ),
            value: val,
            groupValue: radioCategory,
            onChanged: (value)=> onChangeValue(),
            )
            );
  }
}
