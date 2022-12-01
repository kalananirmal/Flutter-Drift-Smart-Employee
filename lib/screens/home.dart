import 'dart:async';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:smart_employee/data/local/db/app_db.dart';
import 'package:smart_employee/widget/custom_employee_details.dart';
import 'package:smart_employee/widget/custom_sliverappbar.dart';
import 'package:provider/provider.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({Key? key}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  AppDb? _db;
  StreamConsumer _controller = StreamController();

  addStreamData() async {
    await Future.delayed(const Duration(seconds: 2));
    // _controller.sink.add(_db);
  }

  @override
  void initState() {
    super.initState();
    addStreamData();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            const CommonSliverAppBar(
              title: 'Hi Employees!!',
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: StreamBuilder<List<EmployeeData>>(
                stream: Provider.of<AppDb>(context).getStreamEmployees(),
                builder: (context, snapshot) {
                  final List<EmployeeData>? employees = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.hasError.toString()),
                    );
                  }
                  if (employees != null) {
                    return ListView.builder(
                        itemCount: employees.length,
                        itemBuilder: (context, index) {
                          final employee = employees[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/edit-employee-screen',
                                  arguments: employee.id);
                            },
                            child: Card(
                              color: Colors.yellow.shade50,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.green.shade400,
                                  style: BorderStyle.solid,
                                  width: 2.2,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  bottomRight: Radius.circular(18.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EmployeeDetail(
                                      value: employee.id.toString(),
                                      hintText: 'Employee ID'),
                                  EmployeeDetail(
                                      value: employee.firstName.toUpperCase(),
                                      hintText: 'Employee First Name'),
                                  EmployeeDetail(
                                      value: employee.lastName.toLowerCase(),
                                      hintText: 'Employee Last Name'),
                                  EmployeeDetail(
                                      value: DateFormat.yMMMd()
                                          .format(employee.dateOfBirth),
                                      // employee.dateOfBirth.toString(),
                                      hintText: 'Date of Birth'),
                                  EmployeeDetail(
                                      value: employee.email,
                                      hintText: 'Employee Email'),
                                  EmployeeDetail(
                                      value: employee.phone,
                                      hintText: 'Contact number'),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return const Text('No Data  found');
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/add-employee-screen');
          },
          label: const Text('Add Employee'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
