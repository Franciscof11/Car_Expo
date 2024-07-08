import 'package:car_expo/modules/cars/presentation/home_page/cubit/cars_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final Widget? sufixIcon;
  final bool? isEmail;
  final TextEditingController? controller;
  final bool isSearch;
  const CustomTextFormField({
    super.key,
    required this.label,
    this.sufixIcon,
    this.controller,
    this.isEmail = false,
    this.isSearch = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo Obrigatório!';
        }
        if (widget.isEmail == true) {
          if (!widget.controller!.text.contains('@') || !widget.controller!.text.contains('.com')) {
            return 'Email inválido!';
          }
        }
        return null;
      },
      onChanged: (value) {
        if (widget.isSearch) context.read<CarsListCubit>().searchCar(value);
      },
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 23, horizontal: 15),
        suffixIconColor: Colors.grey[500],
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
          fontWeight: FontWeight.w600,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey[200],
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.black38,
            width: 2.5,
          ),
        ),
        labelText: widget.label,
        suffixIcon: widget.sufixIcon,
        suffixIconConstraints: const BoxConstraints(minWidth: 70),
      ),
    );
  }
}
