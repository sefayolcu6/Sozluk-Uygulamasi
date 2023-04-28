import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertestproject/Detay.dart';
import 'package:fluttertestproject/Kelimeler.dart';
import 'package:fluttertestproject/Kelimelerdao.dart';

void main() {
  runApp(deneme());
}

class deneme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool AramaYapiliyorMu = false;
  String aramaKelimesi = "";
  Future<List<Kelimeler>> tumKelimeleriGoster() async {
    var kelimlerListesi = await Kelimelerdao().tumKelimeler();
    return kelimlerListesi;
  }

  Future<List<Kelimeler>> aramaYap(String aramaKelimesi) async {
    var kelimlerListesi = await Kelimelerdao().kelimeAra(aramaKelimesi);
    return kelimlerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              AramaYapiliyorMu
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          AramaYapiliyorMu = false;
                          aramaKelimesi = "";
                        });
                      },
                      icon: Icon(Icons.cancel),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          AramaYapiliyorMu = true;
                        });
                      },
                      icon: Icon(Icons.search),
                    )
            ],
            title: AramaYapiliyorMu
                ? TextField(
                    decoration:
                        InputDecoration(hintText: "aramak için bir şey yazın"),
                    onChanged: (aramaSonucu) {
                      print("aramaSonucu:$aramaSonucu");
                      setState(() {
                        aramaKelimesi = aramaSonucu;
                      });
                    },
                  )
                : Text("SÖZLÜK")),
        body: FutureBuilder<List<Kelimeler>>(
          future: AramaYapiliyorMu
              ? aramaYap(aramaKelimesi)
              : tumKelimeleriGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kelimlerListesi = snapshot.data;
              return ListView.builder(
                itemCount: kelimlerListesi!.length,
                itemBuilder: (context, index) {
                  var kelime = kelimlerListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetaySayfa(
                                    kelime: kelime,
                                  )));
                    },
                    child: SizedBox(
                      height: 50,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(kelime.ingilizce),
                            Text(kelime.turkce)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center();
            }
          },
        ));
  }
}
