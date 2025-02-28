import 'package:car_expo/modules/cars/presentation/car_detail_page/car_detail_page.dart';
import 'package:car_expo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../domain/car.dart';

class CarItem extends StatelessWidget {
  final Car car;
  const CarItem({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat('#.000');
    String carValor = formatter.format(car.valor);

    String renderImageCar(int modeloId) {
      switch (modeloId) {
        case 12:
          return 'onix.png';

        case 14:
          return 'jetta.png';

        case 79:
          return 'sw4.png';

        default:
          return '';
      }
    }

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 20, top: 20),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, spreadRadius: 0.5, blurRadius: 15),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          car.nomeModelo,
                          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          car.ano.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'R\$$carValor',
                        style: GoogleFonts.montserrat(
                          fontSize: 17,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CarDetailPage(car: car),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.black87,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                            ),
                          ),
                          child: Text(
                            "Detalhes",
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              color: AppColors.whiteIce,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Image.asset(
              "assets/images/${renderImageCar(car.modeloId)}",
              width: 180,
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}
