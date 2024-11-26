import 'package:flutter/material.dart';
import 'package:hustlehub/users/widgets/checkBoxListWidget.dart';
import 'package:hustlehub/users/widgets/filterTextFieldWidget.dart';
import 'package:hustlehub/users/widgets/textButtonWidget.dart';
import 'package:hustlehub/utils/constants.dart';

class FilterModalSheetWidget extends StatefulWidget {
  const FilterModalSheetWidget({super.key});

  @override
  State<FilterModalSheetWidget> createState() => _FilterModalSheetWidgetState();
}

class _FilterModalSheetWidgetState extends State<FilterModalSheetWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.close),
            const Text(
              "Filter",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: kshowAllColor, fontSize: 15),
                ))
          ],
        ),
        ksizedBoxHeight,
        const Text(
          "Location",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        kheightinRec,
        kheightinRec,
        FilterTextFieldWidget(
          hintText: "Location",
          preicon: const Icon(Icons.location_on),
          suficon: const Icon(Icons.keyboard_arrow_down_outlined),
        ),
        kheightinRec,
        kheightinRec,
        const Text(
          "Company",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        kheightinRec,
        kheightinRec,
        FilterTextFieldWidget(
          hintText: "Search Company",
          preicon: const Icon(Icons.search),
          suficon: const Icon(Icons.cancel_outlined),
        ),
        kheightinRec,
        kheightinRec,
        const Text(
          "Job Type",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        CheckBoxListWidget(title: "Internship",count: "20",),
        CheckBoxListWidget(title: "Full-time",count: "30",),
        CheckBoxListWidget(title: "Part-time",count: "40",),
        kheightinRec,
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ktextColor
              )
            )
          ),
        ),
        kheightinRec,
        const Text(
          "On-Site/Remote",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        CheckBoxListWidget(title: "On-site",count: "20",),
        CheckBoxListWidget(title: "Hybrid",count: "30",),
        CheckBoxListWidget(title: "Remote",count: "40",),
        kheightinRec,
        TextButtonWidget(text: "See 44 results"),
        kheightinRec
      ],
    );
  }
}
