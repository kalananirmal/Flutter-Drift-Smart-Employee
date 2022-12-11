import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_employee/data/local/db/app_db.dart';
import 'package:smart_employee/widget/custom_sliverappbar.dart';
import 'package:smart_employee/widget/custom_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;

class EditEmployeeScreen extends StatefulWidget {
  final int id;

  const EditEmployeeScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  late EmployeeData _employeeData;
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController employeeLastNameController =
      TextEditingController();
  final TextEditingController employeeDobController = TextEditingController();
  final TextEditingController employeeEmailController = TextEditingController();
  final TextEditingController employeeTpController = TextEditingController();
  DateTime? dateOfBirth;
  late FocusNode dob ;

  @override
  void initState() {
    super.initState();
    getEmployee();
    dob = FocusNode();
  }
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    dob.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            const CommonSliverAppBar(
              title: 'Edit You Details',
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'First Name',
                      controller: employeeNameController,
                    ),
                    CustomTextFormField(
                      label: 'Last Name',
                      controller: employeeLastNameController,
                    ),
                    CustomTextFormField(
                      autofocus: true,
                      focusNode: dob,
                      label: 'Date of Birth',
                      controller: employeeDobController,
                      voidCallback: () {
                        pickDateOfBirth(context);
                      },
                    ),
                    CustomTextFormField(
                      label: 'Email',
                      controller: employeeEmailController,
                    ),
                    CustomTextFormField(
                      label: 'Phone',
                      controller: employeeTpController,
                      inputType: TextInputType.number,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            editEmployee();
                          },
                          child: const Text('Edit'),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            editEmployee();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year + 150),
    );
    if (newDate == null) {
      return;
    }
    setState(() {
      dateOfBirth = newDate;
      String dob = DateFormat.yMMMd().format(newDate);
      employeeDobController.text = dob;
    });
  }

  void editEmployee() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      final entity = EmployeeCompanion(
        id: drift.Value(widget.id),
        firstName: drift.Value(employeeNameController.text),
        lastName: drift.Value(employeeLastNameController.text),
        dateOfBirth: drift.Value(dateOfBirth!),
        email: drift.Value(employeeEmailController.text),
        phone: drift.Value(employeeTpController.text),
      );
      Provider.of<AppDb>(context, listen: false).insertEmployee(entity).then(
            (value) => ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                content: Text('New Employee Inserted: $value'),
                contentTextStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                leading: const Icon(Icons.info_outline_rounded),
                actions: [
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                    child: const Text('Close'),
                  ),
                ],
                backgroundColor: Colors.amberAccent.shade100,
              ),
            ),
          );
      dob.requestFocus();
      employeeNameController.clear();
      employeeLastNameController.clear();
      employeeEmailController.clear();
      employeeTpController.clear();
      employeeDobController.clear();
    }
  }

  Future<void> getEmployee() async {
    _employeeData =
        await Provider.of<AppDb>(context, listen: false).getEmployee(widget.id);
    employeeNameController.text = _employeeData.firstName;
    employeeLastNameController.text = _employeeData.lastName;
    employeeDobController.text = _employeeData.dateOfBirth.toIso8601String();
    employeeEmailController.text = _employeeData.email;
    employeeTpController.text = _employeeData.phone;
  }

  void deleteEmployee() {
    Provider.of<AppDb>(context, listen: false).deleteEmployee(widget.id).then(
          (value) => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Delete Alert Box '),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  content: const Text('Employee Deleted'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                );
              }),
        );
  }
}
