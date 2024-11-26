import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';

class OppurtunityTypeWidget extends StatefulWidget {
   ValueChanged<String?> opportunityType; // Callback function

  OppurtunityTypeWidget({super.key,required this.opportunityType});

  @override
  State<OppurtunityTypeWidget> createState() => _OppurtunityTypeWidgetState();
}

class _OppurtunityTypeWidgetState extends State<OppurtunityTypeWidget> {

     String?_selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Opportunity Type',style: TextStyle(
          color: kfontColor,
          fontSize: 13,
          fontWeight: FontWeight.w600
        ),),
              kheightinRec,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0),
                ),
                child: Row(
                  children: [
                    // Internship Radio Button
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            activeColor: kfontColor,
                            value: 'Internship',
                            groupValue: _selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedValue = value;
                              });
                              widget.opportunityType(value);
                            },
                          ),

                          const Text('Internship'),
                        ],
                      ),
                    ),
                    // Job Radio Button
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            activeColor: kfontColor,
                            value: 'Job',
                            groupValue: _selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedValue = value;
                              });
                              widget.opportunityType(value); // Notify parent
                            },
                          ),
                         const Text('Job'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}