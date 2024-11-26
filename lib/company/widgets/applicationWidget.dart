import 'package:flutter/material.dart';
import 'package:hustlehub/utils/constants.dart';

class ApplicationWidget extends StatelessWidget {
  Map<String,dynamic> applications;
  ApplicationWidget({super.key,required this.applications});

  @override
  Widget build(BuildContext context) {

    String status = applications['status']??'';
    Color color;
    if (status == 'approved'){
      color = Colors.green;
    }
    else if(status == 'rejected'){
      color = Colors.red;

    }
    else if (status == 'reviewed'){
      color = Colors.blueAccent.shade700;

    }
    else if (status == 'in review'){
      color = Colors.yellow.shade700;
    }
    else if(status == 'short listed'){
      color = Colors.lightBlue.shade800;
    }
    else {
      color = Colors.white;
    }

    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
                      BoxShadow(
                        color: ktextColor,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                        blurRadius: 3.0,
                       
                      ), 
                      ]//BoxShadow
        ),
        
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(applications['name'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18
                ),
                ),
                Text(applications['email'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14
                ),
                ),
                Text(applications['phone'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: ktextColor
                ),
                ),
               
              ],
            ),
            const Spacer(),
            Column(
             
              children: [
                Text(status.toString().toUpperCase(),style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12
                ),),
                ksizedBoxHeight,
                const CircleAvatar(
                  backgroundColor: kcontainerColor,
                  radius: 10,
                  child: Icon(Icons.arrow_forward_ios,size: 10,))
              ],
            )
          ],
        ),
      );
  }
}