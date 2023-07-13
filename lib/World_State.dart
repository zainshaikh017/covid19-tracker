

// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart'as http;
import 'package:pie_chart/pie_chart.dart';

import 'Countries_State.dart';
import 'Model/wordstate.dart';

class World_State extends StatefulWidget {
  const World_State({super.key});

  @override
  State<World_State> createState() => _World_StateState();
}

class _World_StateState extends State<World_State> with TickerProviderStateMixin{




  Future<Wordstate> getworldstateApi()async{
    final response= await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));

    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return Wordstate.fromJson(data);
    }
    else{
      throw Exception('error');
    }
  }




  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();

  }

  final colorlist=<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: SafeArea(




          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                FutureBuilder(
                  future:getworldstateApi(),
                  builder: (context, snapshot) {

                if(!snapshot.hasData){
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                    color: Colors.black,
                        size: 50.0,
                        controller: _controller,
                  ));
                  }
                  else{
                    return Column(
                      children: [
                      // SizedBox(height: MediaQuery.of(context).size.height*.1,),
                      PieChart(
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        dataMap: {
                          "Total":double.parse(snapshot.data!.cases.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":double.parse(snapshot.data!.deaths.toString()),

                        },
                        chartRadius: MediaQuery.of(context).size.width/3.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left
                        ),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType:  ChartType.ring,
                        colorList: colorlist ,

                      ),
                      Padding(
                        padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                        child: Card(
                          child: Column(
                            children: [
                              Reusable_Row(title: "Total Cases", value: snapshot.data!.cases.toString()),
                              Reusable_Row(title: "Deaths", value: snapshot.data!.deaths.toString()),
                              Reusable_Row(title: "Recovered", value: snapshot.data!.recovered.toString()),
                              Reusable_Row(title: "Active", value: snapshot.data!.active.toString()),
                              Reusable_Row(title: "Critical", value: snapshot.data!.critical.toString()),
                              Reusable_Row(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                              Reusable_Row(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){


                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return const Countries_Screen();
                          },));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      )



                    ],);
                  }
                },),






      ],),
          )),

    );
  }
}



class Reusable_Row extends StatelessWidget {
  String title,value;

   Reusable_Row({
    required this.title,
    required this.value,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10 ,right:10  , top:10 , bottom:5 ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider(),

        ],
      ),
    );
  }
}

