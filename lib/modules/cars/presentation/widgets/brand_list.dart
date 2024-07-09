import 'package:car_expo/modules/cars/presentation/home_page/cubit/cars_list_cubit.dart';
import 'package:car_expo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandList extends StatefulWidget {
  const BrandList({
    super.key,
  });

  @override
  BrandListState createState() => BrandListState();
}

class BrandListState extends State<BrandList> {
  int _brandCategoryIndex = 0;

  var brandList = [
    {
      "name": "all",
      "icon": "",
      "id": 0,
    },
    {
      "name": "chevrolet",
      "icon": "assets/icons/chevrolet_icon.png",
      "id": 1,
    },
    {
      "name": "volks",
      "icon": "assets/icons/volks_icon.png",
      "id": 2,
    },
    {
      "name": "toyota",
      "icon": "assets/icons/toyota_icon.png",
      "id": 3,
    },
  ];

  void setBrandIndex(int currentIndex) {
    setState(() {
      _brandCategoryIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Marcas",
            style: GoogleFonts.montserrat(
              fontSize: 15,
              color: AppColors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: ListView.builder(
            itemCount: brandList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    setBrandIndex(index);
                    debugPrint(brandList[index]["name"].toString());

                    context.read<CarsListCubit>().filterByBrand('0');
                  },
                  child: BrandItem(
                    imgAsset: brandList[index]["icon"].toString(),
                    index: 0,
                    isSelected: (_brandCategoryIndex == index) ? true : false,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    setBrandIndex(index);
                    debugPrint(brandList[index]["name"].toString());

                    final id = brandList[index]["id"].toString();
                    print(id);

                    context.read<CarsListCubit>().filterByBrand(id);
                  },
                  child: BrandItem(
                    imgAsset: brandList[index]["icon"].toString(),
                    index: index,
                    isSelected: (_brandCategoryIndex == index) ? true : false,
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}

class BrandItem extends StatelessWidget {
  final String imgAsset;
  final int index;
  final bool isSelected;

  const BrandItem({
    super.key,
    required this.imgAsset,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (index == 0) ? const EdgeInsets.fromLTRB(20, 12, 10, 12) : const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: (index == 0) ? const EdgeInsets.symmetric(vertical: 20, horizontal: 25) : const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (isSelected)
            ? Colors.blue
            : (index == 0)
                ? Colors.black12
                : Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: (index == 0)
          ? Center(
              child: Text(
                "Todas",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: AppColors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Image.asset(
              imgAsset,
              width: 70,
            ),
    );
  }
}
