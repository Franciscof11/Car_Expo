import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetailPage extends StatefulWidget {
  const CarDetailPage({super.key});

  @override
  CarDetailPageState createState() => CarDetailPageState();
}

class CarDetailPageState extends State<CarDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black87,
          title: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white60,
              size: 30,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopMenuAndShowcase(),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 15, 0, 10),
              child: Text(
                "Specifications",
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/icons/ic_speedometer.png",
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(text: '322'),
                                  TextSpan(
                                    text: ' km/h',
                                    style: TextStyle(
                                      color: Colors.white38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RotatedBox(
                              quarterTurns: 1,
                              child: Image.asset(
                                "assets/icons/ic_cartopview.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(text: 'Liftback'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.montserrat(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w500),
                    children: const <TextSpan>[
                      TextSpan(text: '\$180'),
                      TextSpan(text: '/day', style: TextStyle(color: Colors.black38)),
                    ],
                  ),
                ),
              ),
              Container(
                width: 170,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarDetailPage()));
                  },
                  child: Text(
                    "EU QUERO",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopMenuAndShowcase extends StatelessWidget {
  const TopMenuAndShowcase({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 70,
            right: 20,
            left: 20,
            bottom: 0,
            child: Image.asset(
              "assets/images/tesla_1.png",
              width: 300,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 18, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 7, spreadRadius: 0.5)],
                        ),
                        child: Image.asset(
                          "assets/icons/toyota_icon.png",
                          width: 25,
                          height: 25,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tesla Model S",
                            ),
                            Text(
                              "2021",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
