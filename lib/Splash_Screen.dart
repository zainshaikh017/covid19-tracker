// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math'as math;

import 'World_State.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen>with TickerProviderStateMixin {

  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();

  }


  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const World_State();
      },));
    });
  }
  @override

  Widget build(BuildContext context) {
    // double width=MediaQuery.of(context).size.width;width
    // double height=MediaQuery.of(context).size.height;
    return
      Scaffold(
        
        
        
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                  child: const SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Image(
                          image: AssetImage('images/image01.png')),
                    ),
                  ),
                  builder: (

                      BuildContext context,Widget? child) {
                    return Transform.rotate(

                      angle:_controller.value*2.0* math.pi ,
                      child: child,


                    );
                  },),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.08,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text('Covid-19\nTracker App',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),),
              )


            ],
          ),
        ),




      );
  }
}
