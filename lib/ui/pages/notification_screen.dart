import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {

  String payload;

  NotificationScreen(this.payload);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

 late String _payload;
  @override
  void initState() {
    // TODO: implement initState
    _payload=widget.payload;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () =>Get.back() ,
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          _payload.toString().split('|')[0],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'heloooooooo',
                    style: TextStyle(
                      fontWeight:FontWeight.w900,
                      color: darkGreyClr
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'hiiiiiiiiiiiii',
                    style: TextStyle(
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child:Container(
                  padding:EdgeInsets.symmetric(horizontal: 30,vertical: 30) ,
                  margin:EdgeInsets.symmetric(vertical: 30,horizontal: 30) ,
                  decoration: BoxDecoration(
                    color: primaryClr,
                    borderRadius: BorderRadius.circular(40),

                  ),
                  
                  
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        children: [
                          Icon(Icons.title,color: white,),
                          SizedBox(width: 10,),
                          Text(
                            'title',
                           style:TextStyle(
                            fontSize: 30,
                            color: white,
                            fontWeight: FontWeight.w500
                           ) ,
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        _payload.toString().split('|')[0],
                        
                        ),
                      SizedBox(height: 10,),


                      Row(
                        children: [
                          Icon(Icons.description,color: white,),
                          SizedBox(width: 10,),
                          Text(
                            'description',
                           style:TextStyle(
                            fontSize: 30,
                            color: white,
                            fontWeight: FontWeight.w500
                           ) ,
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        _payload.toString().split('|')[1]
                      ),
                      SizedBox(height: 10,),


                      
                      Row(
                        children: [
                          Icon(Icons.punch_clock_outlined,color: white,),
                          SizedBox(width: 10,),
                          Text(
                            'date',
                           style:TextStyle(
                            fontSize: 30,
                            color: white,
                            fontWeight: FontWeight.w500
                           ) ,
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        _payload.toString().split("|")[2]
                        ),
                      SizedBox(height: 10,),

                    ],
                  ),
                )
                ),
            ],
          ),
        ),
      ),
    );
  }
}
