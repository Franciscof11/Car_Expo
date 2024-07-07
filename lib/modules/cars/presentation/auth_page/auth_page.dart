import 'package:car_expo/config/database/user/user_db.dart';
import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:car_expo/modules/cars/presentation/home_page/cubit/cars_list_cubit.dart';
import 'package:car_expo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../home_page/home_page.dart';
import '../widgets/custom_text_form_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();

  final emailTextController = TextEditingController();

  final userDB = UserDB();

  @override
  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteIce,
        body: Form(
          key: formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              color: AppColors.black87,
                            ),
                            children: const [
                              TextSpan(text: 'Car'),
                              TextSpan(text: 'Expo', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/icons/icon_app.png',
                          width: 80,
                          height: 80,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Bem-vindo ao CarExpo! Aqui, você pode registrar seu interesse em qualquer carro disponível. Para começar, identifique-se e descubra as melhores ofertas!',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          color: AppColors.customGrey,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Identifique-se',
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        color: AppColors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomTextFormField(
                      label: 'Nome',
                      controller: nameTextController,
                      sufixIcon: Icon(
                        Icons.person_rounded,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      label: 'Email',
                      controller: emailTextController,
                      sufixIcon: Icon(
                        Icons.email,
                        color: Colors.grey[700],
                      ),
                      isEmail: true,
                    ),
                    const SizedBox(height: 80),
                    Center(
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.black87,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            final validForm = formKey.currentState?.validate() ?? false;

                            if (validForm) {
                              await userDB.createUser(name: nameTextController.text, email: emailTextController.text);

                              if (context.mounted) {
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
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Próximo',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
