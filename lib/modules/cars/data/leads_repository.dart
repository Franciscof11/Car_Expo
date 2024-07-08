import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../domain/lead.dart';

class LeadsRepository {
  Future<void> postLeads(List<Lead> leads) async {
    try {
      final dio = Dio();

      final response = await dio.post(
        'https://www.wswork.com.br/cars/leads',
        options: Options(
          followRedirects: true,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: [
          {"leadId": 1, "carId": 1, "carName": "onix teste 2", "username": "Francisco teste 2"},
          {"leadId": 1, "carId": 1, "carName": "onix teste 2", "username": "Francisco teste 2"}
        ],
      );

      if (response.statusCode == 200) {
        print('Leads posted successfully!');
      }
    } catch (e) {
      debugPrint('Unexpected Error: $e');

      return;
    }
  }
}
