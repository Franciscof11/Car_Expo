import 'package:car_expo/config/database/leads/leads_db.dart';
import 'package:car_expo/config/database/user/user_db.dart';
import 'package:car_expo/modules/cars/domain/car.dart';
import 'package:car_expo/modules/cars/presentation/lead_feedback_page/lead_feedback_page.dart';
import 'package:car_expo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class CarDetailPage extends StatefulWidget {
  final Car car;
  const CarDetailPage({super.key, required this.car});

  @override
  CarDetailPageState createState() => CarDetailPageState();
}

class CarDetailPageState extends State<CarDetailPage> {
  final leadDb = LeadsDB();
  final userDB = UserDB();
  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat('#.000');
    String carValor = formatter.format(widget.car.valor);

    Widget renderImageCar(int modeloId) {
      switch (modeloId) {
        case 12:
          return Image.asset(
            "assets/images/onix.png",
            width: 500,
            height: 500,
          );

        case 14:
          return Image.asset(
            "assets/images/jetta.png",
            width: 230,
            height: 230,
          );

        case 79:
          return Image.asset(
            "assets/images/sw4.png",
            width: 400,
            height: 400,
            fit: BoxFit.cover,
          );

        default:
          return Container();
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black87,
          title: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 40,
                color: AppColors.whiteIce,
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: AppColors.black87,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: renderImageCar(widget.car.modeloId),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                "Ficha Técnica",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  color: AppColors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 22),
                          Text(
                            "Modelo: ${widget.car.nomeModelo}",
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: AppColors.whiteIce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 22),
                          Text(
                            "Ano de lançamento: ${widget.car.ano}",
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: AppColors.whiteIce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 22),
                          Text(
                            "Combustível: ${widget.car.combustivel}",
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: AppColors.whiteIce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 22),
                          Text(
                            "Número de portas: ${widget.car.numPortas}",
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: AppColors.whiteIce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Text(
                'R\$$carValor',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 170,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  final user = await userDB.getUser();
                  await leadDb.create(
                    carId: widget.car.id,
                    carName: widget.car.nomeModelo.toLowerCase(),
                    userName: user.name,
                    userEmail: user.email,
                  );

                  if (context.mounted) {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const LeadFeedbackPage(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                    ),
                  ),
                ),
                child: Text(
                  "EU QUERO",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
