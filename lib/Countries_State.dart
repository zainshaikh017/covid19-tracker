// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shimmer/shimmer.dart';

import 'Countrie_details.dart';




class Countries_Screen extends StatefulWidget {
  const Countries_Screen({super.key});

  @override
  State<Countries_Screen> createState() => _Countries_ScreenState();
}

class _Countries_ScreenState extends State<Countries_Screen> {

  Future<List<dynamic>> getcountrieApi()async{
    var data ;
    final response= await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));

    if(response.statusCode==200){
      data=jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('error');
    }
  }

  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(



      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
     iconTheme: const IconThemeData(
       color: Colors.black
     ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: search,
                decoration: InputDecoration(
                  hintText: "Search With Countries Name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              ),


              Expanded(
                child: FutureBuilder(
                  future: getcountrieApi(),
                  builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return ListView.builder(
                      itemCount:10 ,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor:Colors.grey.shade100,
                          child:  Column(
                            children: [
                              ListTile(
                                title : Container(
                                  height: 10,
                                  width: 89,
                                    color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading:Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),

                              ),


                            ],
                          ) ,
                        );

                      },);
                  }
                  else{
                    return ListView.builder(
                    itemCount:snapshot.data!.length ,
                    itemBuilder: (context, index) {
                      String name=snapshot.data![index]["country"];
                      if(search.text.isEmpty){
                        return Column(
                          children: [
                            InkWell(
                              onTap : (){
                                Navigator.of(context).push(MaterialPageRoute(builder:  (context) {
                                  return Detail_(
                                    name: snapshot.data![index]["country"],
                                    image: snapshot.data![index]['countryInfo']["flag"],
                                    totalCases: snapshot.data![index]["todayCases"],
                                    totalDeaths: snapshot.data![index]["deaths"],
                                    totalrecoverd: snapshot.data![index]["recovered"],
                                    active: snapshot.data![index]["active"],
                                    critical:snapshot.data![index]["critical"],
                                    todayrecoverd: snapshot.data![index]["todayRecovered"],
                                    test: snapshot.data![index]["tests"],) ;
                                },));
                              },
                              child: ListTile(
                                title : Text(snapshot.data![index]["country"]),
                                subtitle: Text(snapshot.data![index]["cases"].toString()),
                                leading: Image.network(
                                    snapshot.data![index]['countryInfo']["flag"]
                                ),

                              ),
                            ),
                            const Divider()

                          ],
                        ) ;
                      }
                      else if(name.toLowerCase().contains(search.text.toLowerCase())){
                        return Column(
                          children: [
                            InkWell(
                              onTap : (){
                                Navigator.of(context).push(MaterialPageRoute(builder:  (context) {
                                  return Detail_(
                                    name: snapshot.data![index]["country"],
                                    image: snapshot.data![index]['countryInfo']["flag"],
                                    totalCases: snapshot.data![index]["todayCases"],
                                    totalDeaths: snapshot.data![index]["deaths"],
                                    totalrecoverd: snapshot.data![index]["recovered"],
                                    active: snapshot.data![index]["active"],
                                    critical:snapshot.data![index]["critical"],
                                    todayrecoverd: snapshot.data![index]["todayRecovered"],
                                    test: snapshot.data![index]["tests"],) ;
                                },));
                              },
                              child: ListTile(
                                title : Text(snapshot.data![index]["country"]),
                                subtitle: Text(snapshot.data![index]["cases"].toString()),
                                leading: Image.network(
                                    snapshot.data![index]['countryInfo']["flag"]
                                ),

                              ),
                            ),
                            const Divider()

                          ],
                        ) ;
                      }
                      else{
                        return Container();

                        }


                    },);

                  }
                },),
              )








            ],
          ),
        ),
      ),
    );
  }
}


