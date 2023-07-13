// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';

import 'World_State.dart';

class Detail_ extends StatefulWidget {

  String image,name;
  int  totalCases, totalDeaths,totalrecoverd,active,critical,todayrecoverd,test;

     Detail_({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalrecoverd,
    required this.active,
    required this.critical,
    required this.todayrecoverd,
    required this.test,


    super.key});

  @override
  State<Detail_> createState() => _Detail_State();
}

class _Detail_State extends State<Detail_> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.name,style: const TextStyle(
          color: Colors.black
        ),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.067,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [



                  Padding(
                    padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.067,),
                          Reusable_Row(title: "Total Cases", value: widget.totalCases.toString(),),
                          Reusable_Row(title: "Deaths", value: widget.totalDeaths.toString()),
                          Reusable_Row(title: "Recovered", value: widget.totalrecoverd.toString()),
                          Reusable_Row(title: "Active", value: widget.active.toString()),
                          Reusable_Row(title: "Critical", value: widget.critical.toString()),
                          Reusable_Row(title: "Today Test", value: widget.test.toString()),
                          Reusable_Row(title: "Today Recovered", value:widget.todayrecoverd.toString()),
                        ],
                      ),
                    ),
                  ),

                  CircleAvatar(
                    radius: 60,
                     backgroundImage: NetworkImage(widget.image),
                  ),
                ],

              ),
            ),
          ],
        ),
      ),

      
    );
  }
}
