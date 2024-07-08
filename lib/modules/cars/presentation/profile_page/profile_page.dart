import 'package:car_expo/config/database/leads/leads_db.dart';
import 'package:car_expo/config/database/user/user_db.dart';
import 'package:car_expo/modules/cars/domain/user.dart';
import 'package:car_expo/modules/cars/presentation/auth_page/auth_page.dart';
import 'package:car_expo/modules/cars/presentation/profile_page/cubit/user_cubit.dart';
import 'package:car_expo/modules/cars/presentation/widgets/loader.dart';
import 'package:car_expo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userDB = UserDB();
    final leadsDB = LeadsDB();
    return BlocSelector<UserCubit, UserState, User>(
      selector: (state) => state.maybeWhen(
        data: (user) => user,
        orElse: () => User.empy(),
      ),
      builder: (context, user) {
        return Scaffold(
          backgroundColor: AppColors.whiteIce,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Perfil",
                          style: GoogleFonts.montserrat(
                            fontSize: 28,
                            color: AppColors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                        'Bem-vindo à sua página de perfil! Aqui, você pode visualizar suas informações pessoais de maneira rápida e segura.',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          color: AppColors.customGrey,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/images/profile_image.png',
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Dados",
                      style: GoogleFonts.montserrat(
                        fontSize: 25,
                        color: AppColors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Loader<UserCubit, UserState>(
                        selector: (state) => state.maybeWhen(
                          orElse: () => false,
                          loading: () => true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Nome: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: user.name),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: user.email),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: ElevatedButton(
                        onPressed: () async {
                          await userDB.clearTable();
                          await leadsDB.clearTable();
                          if (context.mounted) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black87,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sair',
                              style: GoogleFonts.montserrat(
                                color: AppColors.whiteIce,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
