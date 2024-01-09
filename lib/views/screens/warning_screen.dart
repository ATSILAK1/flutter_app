import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/views/screens/add_video_screen.dart';
import 'package:tiktok_tutorial/views/widgets/picken.dart';

class WarningScreen extends StatelessWidget {
  const WarningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Color.fromRGBO(22, 22, 22, 1)),
          ),
          Positioned(
              top: 30,
              left: 37,
              child: Container(
                width: 329,
                height: 324,
                color: Color.fromRGBO(221, 125, 255, 1),
              )),
          Positioned(
              top: 50,
              left: 60,
              width: 296,
              child: Text(
                " Les postes contenant de la musique ne sont pas autorisés, seuls les fonds sonores le sont. Testez votre poste en cliquant ici avant de le publier.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w800),
              )),
          Positioned(
              top: 131,
              left: 60,
              width: 296,
              child: Text(
                " Danse, sexualité, vulgarité et tenues vestimentaires suggestives sont strictement interdites.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w800),
              )),
          Positioned(
              top: 210,
              left: 60,
              width: 296,
              child: Text(
                " Les postes contenant des paroles injurieuses, obscènes, grossières et haineuses sont contraire a notre politique et seront supprimés.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w800),
              )),
          Positioned(
              top: 290,
              left: 60,
              width: 296,
              child: Text(
                " Tout contenu choquant, violent et illicite fera l’objet d'une suspension de votre compte.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w800),
              )),
          Positioned(
              top: 383,
              left: 37,
              child: Container(
                width: 333,
                height: 120,
                color: Color.fromRGBO(221, 125, 255, 1),
              )),
          Positioned(
              top: 400, left: 9, child: Image.asset('assets/img/ThumbUp.png')),
          Positioned(
              top: 400,
              left: 345,
              child: Image.asset('assets/img/Exclamation.png')),
          Positioned(
              top: 383,
              width: 290,
              left: 60,
              child: Text(
                "Nous vous encourageons vivement à signaler tout contenu en violation de notre politique grâce au bouton jaune. En plus de nos filtres, votre collaboration est cruciale pour maintenir un espace sain, apaisant et éducatif.",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              )),
          Positioned(
              top: 292,
              left: 12,
              child: Image.asset('assets/img/interdit.png')),
          Positioned(
              top: 212, left: 12, child: Image.asset('assets/img/langage.png')),
          Positioned(
              top: 132, left: 9, child: Image.asset('assets/img/oeil.png')),
          Positioned(
              top: 52, left: 9, child: Image.asset('assets/img/Musique.png')),
                   Positioned(
                    width: 54,
                    height: 54,
              top: 593, left: 166, child: GestureDetector(
                onTap:() => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddVideoScreen(),
                      ),),
                child: Image.asset('assets/img/Add.png'))),
        ],
      ),
    );
  }
}
