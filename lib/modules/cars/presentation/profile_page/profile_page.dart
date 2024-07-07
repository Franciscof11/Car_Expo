import 'package:car_expo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteIce,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
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
                  'assets/profile_image.png',
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
              RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: 'Nome: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Francisco Gabriel'),
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
                  children: const <TextSpan>[
                    TextSpan(text: 'Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'chico@teste.com'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
