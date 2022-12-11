import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_employee/data/local/db/app_db.dart';
import 'package:smart_employee/widget/custom_sliverappbar.dart';
import 'package:smart_employee/widget/custom_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController employeeLastNameController =
      TextEditingController();
  final TextEditingController employeeDobController = TextEditingController();
  final TextEditingController employeeEmailController = TextEditingController();
  final TextEditingController employeeTpController = TextEditingController();
  DateTime? dateOfBirth;
  late FocusNode firstname;

  @override
  void initState() {
    super.initState();
    firstname = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    firstname.dispose();

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
              title: 'Hi Enter Your Details',
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      autofocus: true,
                      focusNode: firstname,
                      label: 'First Name',
                      controller: employeeNameController,
                      maxLength: 50,
                      minLength: 3,
                    ),
                    CustomTextFormField(
                      label: 'Last Name',
                      controller: employeeLastNameController,
                      maxLength: 50,
                      minLength: 3,
                    ),
                    CustomTextFormField(
                      label: 'Date of Birth',
                      controller: employeeDobController,
                      voidCallback: () {
                        pickDateOfBirth(context);
                      },
                      minLength: 3,
                      maxLength: 50,
                    ),
                    CustomTextFormField(
                      label: 'Email',
                      controller: employeeEmailController,
                      minLength: 3,
                      maxLength: 50,
                    ),
                    CustomTextFormField(
                      label: 'Phone',
                      controller: employeeTpController,
                      inputType: TextInputType.number,
                      maxLength: 10,
                      minLength: 3,
                    ),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          saveEmployee();
                        },
                        child: const Text('Save'),
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

  void saveEmployee() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      final entity = EmployeeCompanion(
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
     firstname.requestFocus();
      employeeNameController.clear();
      employeeLastNameController.clear();
      employeeEmailController.clear();
      employeeTpController.clear();
      employeeDobController.clear();
    }
  }
}
