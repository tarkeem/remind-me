import 'package:flutter/material.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
  String title;
  String? note;
  Widget? widg;
  TextEditingController? cotroll;
  InputField({
  required this.title,
  this.cotroll,
  required this.note,
  this.widg
  }
  );

  


  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width:SizeConfig.screenWidth ,
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Text(title.toString(),style: titlestyle,),
        Expanded (//if there is row/column inside row/column, Expanded should be used
           child: Row(
             children: [
               Expanded(
                  child:Container(
                        padding: EdgeInsets.only(left:20 ) ,
                        margin: EdgeInsets.only(left:20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextFormField(
                          controller: cotroll,
                          readOnly: widg==null?false:true,
                          cursorColor:Colors.blueAccent ,
                          decoration: InputDecoration(
                            hintText: note,
                            hintStyle: subtitlestyle,
                            enabledBorder:UnderlineInputBorder( //border when not focusing on input field
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color:Colors.black,//Themes().light_mode.backgroundColor,
                                width: 0.1
                              ),
                              
                            ) ,
                            focusedBorder:UnderlineInputBorder( //border when not focusing on input field
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.1
                              )
         
                            ) 
                          ),
                        ),
                      ),
                    
                   
                    
                    
                    
                  
                ),
             widg??Container(width:0 ,height:0 ,)
             
             ],
           ),
         ),
        ],
      )
      );
  }
}
