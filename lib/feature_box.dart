import 'package:ai_assistance/pallete.dart';
import 'package:flutter/cupertino.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox({super.key,required this.color,required this.headerText,
  required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20),)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20,bottom: 20,left: 15,right: 15),
        child: Column(
          children: [
             Align(alignment: Alignment.centerLeft,
               child: Text(headerText,style: TextStyle(
                  fontFamily: 'Cera Pro',
                   color: Pallete.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),),
             ),
            SizedBox(height: 4,),
            Align(alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(descriptionText,style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,
                  fontSize: 18
                ),),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
