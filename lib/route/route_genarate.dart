import 'package:flutter/material.dart';
import 'package:smart_employee/screens/add_employee.dart';
import 'package:smart_employee/screens/edit_employee.dart';
import 'package:smart_employee/screens/home.dart';
import 'package:lottie/lottie.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const EmployeeDetails());
      case '/add-employee-screen':
        return MaterialPageRoute(builder: (_) => const AddEmployeeScreen());
      case '/edit-employee-screen':
        if (args is int ){
          return MaterialPageRoute(builder: (_) =>  EditEmployeeScreen(id: args));

        }
        return _errorPage();

      default:
        return _errorPage();
    }
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(builder: (_) {
      return  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/errorpage_robot.json',
                animate: false,
                width: 300,
                height: 300,
              ),
              const SizedBox(
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Something went wrong at our end. Don\'t worry, it\'s not you - it\'s us. Sorry about that. ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
