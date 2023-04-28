import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertestproject/Kelimeler.dart';

class DetaySayfa extends StatefulWidget {
  final Kelimeler kelime;

  const DetaySayfa({super.key, required this.kelime});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detay Sayfası"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.kelime.turkce,
                style: TextStyle(color: Colors.red, fontSize: 50),
              ),
              Text(
                widget.kelime.ingilizce,
                style: TextStyle(color: Colors.black, fontSize: 50),
              )
            ],
          ),
        ));
  }
}
