import 'package:flutter/material.dart';

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
              left: 52,
              width: 296,
              child: Text(
                " Les postes contenant de la musique ne sont pas autorisés, seuls les fonds sonores le sont. Testez votre poste en cliquant ici avant de le publier.",
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.black ,fontSize: 13, fontWeight: FontWeight.w800),
                
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
        ],
      ),
    );
  }
}
