import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hustlehub/routes/routeConstants.dart';
import 'package:hustlehub/utils/constants.dart';

class JobDetailsWidget extends StatefulWidget {
  ValueChanged<String?> jobTitle;
  ValueChanged<int?> yearsOfExp;
  ValueChanged<String?> skillsRequired;
  ValueChanged<String?> jobType;
  ValueChanged<String?> location;
  ValueChanged<LatLng> latlng;
  ValueChanged<String?> jobTime;
  ValueChanged<int?> openingsCount;
  ValueChanged<List<String>> jobDesc;
  ValueChanged<List<String>> preferences;
  JobDetailsWidget({super.key,
  required this.jobTitle,
  required this.yearsOfExp,
  required this.skillsRequired,
  required this.jobType,
  required this.jobTime,
  required this.openingsCount,
required this.jobDesc,
required this.preferences,
required this.location,
required this.latlng,

  });

  @override
  State<JobDetailsWidget> createState() => _JobDetailsWidgetState();
}

class _JobDetailsWidgetState extends State<JobDetailsWidget> {
  int _selectedYear = 0;

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController openingsCountController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController preferenceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController latlngController = TextEditingController();
  var _selectedTime,_selectedType;
  List<String> preferences =[];
  List<String> jobDesc =[];

  Future<void> _navigateToGoogleMapScreen(BuildContext context) async {
    // Check for permission and get the current location
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission is denied")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Convert position to LatLng
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    // Navigate to GoogleMapScreen with current location as argument
    final selectedLocation = await Navigator.pushNamed(
      context,
      AppRoute.googleMapScreen,
      arguments: currentLocation,
    );
     if (selectedLocation != null && selectedLocation is LatLng) {
    // Store the selected location
    LatLng location = selectedLocation;
    setState(() {
      widget.latlng(location);
    });
     }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job details',
          style: TextStyle(
              color: kfontColor, fontSize: 13, fontWeight: FontWeight.w600),
        ),
        kheightinRec,
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(width: 0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Job title',
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 13,
                ),
              ),
              kheightinRec,
              TextField(
                controller: jobTitleController,
                onChanged: (value) {
                  widget.jobTitle(value);
                },
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    hintText: 'eg.Software Engineer Trainee',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: ktextColor
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kfontColor,
                    )),
                    border: OutlineInputBorder()),
              ),
              ksizedBoxHeight,
              const Text(
                'Required years of experience',
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 13,
                ),
              ),
              kheightinRec,
              TextField(
                readOnly: true,
                controller: yearsController,
              
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    suffixIcon: PopupMenuButton(
                      
                      icon: const Icon(Icons.arrow_drop_down),
                      itemBuilder: (context) => List.generate(10, (index) {
                        return PopupMenuItem(
                          value: index + 1,
                          child: Text('${index + 1}'),
                        );
                      }),
                      onSelected: (value) {
                        setState(() {
                          _selectedYear = value;
                          yearsController.text = _selectedYear.toString();
                           widget.yearsOfExp(_selectedYear);
                        });
                      },
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kfontColor,
                    )),
                    border: const OutlineInputBorder()),
              ),
              ksizedBoxHeight,
              const Text(
                'Skills Required',
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 13,
                ),
              ),
              kheightinRec,
              TextField(
                controller: skillController,
                onChanged: (value) {
                  widget.skillsRequired(value);
                },
                decoration: const InputDecoration(
                    hintText: 'e.g. Java',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: ktextColor
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kfontColor,
                    )),
                    border: OutlineInputBorder()),
              ),
              ksizedBoxHeight,
              const Text(
                'Job type',
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 13,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio<String>(
                  
                    activeColor: kfontColor,
                    value: 'In Office',
                    groupValue: _selectedType,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedType = value;
                      });
                       widget.jobType(value);
                    },
                  ),

                  const Text('In Office'),
                  // Job Radio Button
                  Radio<String>(
                    activeColor: kfontColor,
                    value: 'Hybrid',
                    groupValue: _selectedType,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedType = value;
                      });
                      widget.jobType(value);
                    },
                  ),
                  const Text('Hybrid'),
                  Radio<String>(
                    activeColor: kfontColor,
                    value: 'Remote',
                    groupValue: _selectedType,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedType = value;
                      });
                       widget.jobType(value);
                    },
                  ),
                  const Text('Remote'),
                ],
              ),
              kheightinRec,
              if(_selectedType == 'In Office')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Job Location',
                    style: TextStyle(
                      color: kfontColor,
                      fontSize: 13,
                    ),
                  ),
                  kheightinRec,
                  TextField(
                controller: locationController,
                onChanged: (value) {
                  widget.location(value); 
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: (){
                      _navigateToGoogleMapScreen(context);
                    }, icon: const Icon(Icons.location_on_outlined)),
                    hintText: 'e.g. Banglore',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: ktextColor
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kfontColor,
                    )),
                    border: const OutlineInputBorder()),
              ),
                ],
              ),
              

            ksizedBoxHeight,
              const Text(
                'Part-time/Full-time',
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 13,
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio<String>(
                  
                    activeColor: kfontColor,
                    value: 'Part-Time',
                    groupValue: _selectedTime,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedTime = value;
                      });
                      widget.jobTime(value);
                    },
                  ),

                  const Text('Part-Time'),
                  // Job Radio Button
                  Radio<String>(
                    activeColor: kfontColor,
                    value: 'Full-Time',
                    groupValue: _selectedTime,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedTime = value;
                      });
                      widget.jobTime(value);
                    },
                  ),
                  const Text('Full-Time'),
                ]
              ),
              const Text(
                'Number of openings',
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 13,
                ),
              ),
              kheightinRec,
              TextField(
                keyboardType: TextInputType.number,
                controller: openingsCountController,
                onChanged: (value) {
                  widget.openingsCount(int.tryParse(value));
                },
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    hintText: 'eg.4',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: ktextColor
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kfontColor,
                    )),
                    border: OutlineInputBorder()),
              ),
              ksizedBoxHeight,
              const Text(
                'Job description',
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 13,
                ),
              ),
              kheightinRec,
              TextField(
                

                controller: descController,
                
               
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (){
                      jobDesc.add(descController.text);
                  widget.jobDesc(jobDesc);
                  descController.clear();
                    },
                    icon: const Icon(Icons.add)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    hintText: 'Key Responsibilities\n1.\n2.\n3.',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: ktextColor
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kfontColor,
                    )),
                    border: const OutlineInputBorder()),
              ),
              ksizedBoxHeight,
              const Text(
                'Additional candidate preference',
                style: TextStyle(
                  color: kfontColor,
                  fontSize: 13,
                ),
              ),
              kheightinRec,
              TextField(
               
                controller: preferenceController,
                
                decoration:InputDecoration(
                  
                  suffixIcon:IconButton(onPressed: (){
                    preferences.add(preferenceController.text);
                    widget.preferences(preferences);
                    preferenceController.clear();
                  }, 
                  icon: const Icon(Icons.add)) ,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    hintText: '1.eg.Computer Science Graduate preferred\n2.\n3.',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: ktextColor
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kfontColor,
                    )),
                    border: const OutlineInputBorder()),
              ),
            ],
          ),
        )
      ],
    );
  }
}
