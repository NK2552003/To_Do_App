import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:to_do/Pages/font_bold.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,required this.txt,required this.icon,required this.valuetxt,required this.onTap
  });
  final String txt;
  final String valuetxt;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(txt, style: AppStyle.headingOne),
        const Gap(6),
        Ink(
          color:Colors.grey.shade300,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>onTap(),
            child: Container(
              padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Icon(icon),
                const Gap(6),
                Text(valuetxt),
              ],),
            ),
          ),
        ),
      ],
    ));
  }
}
