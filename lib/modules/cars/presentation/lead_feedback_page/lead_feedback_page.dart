import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:car_expo/modules/cars/presentation/home_page/cubit/cars_list_cubit.dart';
import 'package:car_expo/modules/cars/presentation/home_page/home_page.dart';
import 'package:car_expo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LeadFeedbackPage extends StatelessWidget {
  const LeadFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 120),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 275),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          right: 20,
                          left: 20,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.blue,
                              size: 44,
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Text(
                                'Solicitação de compra enviada com sucesso!',
                                style: GoogleFonts.montserrat(
                                  color: Colors.blue,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/lead_feedback.png',
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: BlocProvider(
                      create: (context) => CarsListCubit(repository: context.read<CarsRepository>())..getAllCars(),
                      child: const HomePage(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
              ),
              child: Text(
                'Ir para Home',
                style: GoogleFonts.montserrat(
                  color: AppColors.whiteIce,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
