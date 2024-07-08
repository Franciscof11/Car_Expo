import 'dart:io';
import 'package:car_expo/config/database/user/user_db.dart';
import 'package:car_expo/modules/cars/data/leads_repository.dart';
import 'package:car_expo/modules/cars/presentation/profile_page/profile_page.dart';
import 'package:car_expo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/database/leads/leads_db.dart';
import '../../domain/car.dart';
import '../../domain/lead.dart';
import '../../domain/user.dart';
import '../profile_page/cubit/user_cubit.dart';
import '../widgets/brand_list.dart';
import '../widgets/cars_item.dart';
import '../widgets/loader.dart';
import 'cubit/cars_list_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isVisible = true;
  final ScrollController _scrollController = ScrollController();

  final leadDb = LeadsDB();
  final userDb = UserDB();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isVisible) {
        setState(() {
          _isVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteIce,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocSelector<UserCubit, UserState, User>(
                      selector: (state) => state.maybeWhen(
                        data: (user) => user,
                        orElse: () => User.empty(),
                      ),
                      builder: (context, user) {
                        return RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 26,
                              color: Colors.black87,
                            ),
                            children: <TextSpan>[
                              const TextSpan(text: 'Olá,', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: ' ${user.name.split(' ').first}!'),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      onPressed: () async {
                        final user = await userDb.getUser();

                        debugPrint('### USER ###');
                        debugPrint(user.toString());
                      },
                    ),
                  ],
                ),
              ),
              const BrandList(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Carros Disponíveis",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              color: AppColors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final List<Lead> leads = await leadDb.getAll();

                              for (var lead in leads) {
                                debugPrint('#LEAD -> $lead');
                              }

                              final leadsRepository = LeadsRepository();

                              leadsRepository.postLeads(leads);
                            },
                            icon: const Icon(Icons.sort),
                          )
                        ],
                      ),
                      Center(
                        child: Loader<CarsListCubit, CarsListState>(
                          selector: (state) => state.maybeWhen(
                            orElse: () => false,
                            loading: () => true,
                          ),
                        ),
                      ),
                      BlocSelector<CarsListCubit, CarsListState, List<Car>>(
                        selector: (state) => state.maybeWhen(
                          data: (cars) => cars,
                          orElse: () => [],
                        ),
                        builder: (context, cars) {
                          return Expanded(
                            child: RefreshIndicator(
                              color: AppColors.black87,
                              onRefresh: () async {
                                context.read<CarsListCubit>().getAllCars();
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount: cars.length,
                                itemBuilder: (context, index) {
                                  final car = cars[index];
                                  return CarItem(car: car);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: _isVisible
              ? Container(
                  margin: EdgeInsets.only(right: 20, left: 20, bottom: Platform.isAndroid ? 15 : 0),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.black87.withOpacity(0.8),
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF17203A).withOpacity(0.3),
                        offset: const Offset(0, 20),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.grid_view, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.person, color: Colors.white),
                        onPressed: () async {
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: BlocProvider(
                                  create: (context) => UserCubit(userDb)..getUser(),
                                  child: const ProfilePage(),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
