import 'package:flutter/material.dart';

class LinkFormPage extends StatefulWidget {
  const LinkFormPage({super.key});

  @override
  State<LinkFormPage> createState() => _LinkFormPageState();
}

class _LinkFormPageState extends State<LinkFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _baseUrlController = TextEditingController();
  final _pathController = TextEditingController();
  final _subbaseUrlController = TextEditingController();
  final _regiController = TextEditingController();
  final _rollController = TextEditingController();
  final _yearController = TextEditingController();
  final _regiController1 = TextEditingController();
  final _rollController1 = TextEditingController();
  final _yearController1 = TextEditingController();
  final _regiController2 = TextEditingController();
  final _rollController2 = TextEditingController();
  final _yearController2 = TextEditingController();
  final _regiController3 = TextEditingController();
  final _rollController3 = TextEditingController();
  final _yearController3 = TextEditingController();
  final _exp1Controller = TextEditingController();
  final _sbase1Controller = TextEditingController();
  final _exp2Controller = TextEditingController();
  final _sbase2Controller = TextEditingController();
  final _exp3Controller = TextEditingController();
  final _sbase3Controller = TextEditingController();
  final _exp4Controller = TextEditingController();
  final _sbase4Controller = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _baseUrlController.dispose();
    _pathController.dispose();
    _subbaseUrlController.dispose();
    _regiController.dispose();
    _rollController.dispose();
    _yearController.dispose();
    _regiController1.dispose();
    _rollController1.dispose();
    _yearController1.dispose();
    _regiController2.dispose();
    _rollController2.dispose();
    _yearController2.dispose();
    _regiController3.dispose();
    _rollController3.dispose();
    _yearController3.dispose();
    _exp1Controller.dispose();
    _sbase1Controller.dispose();
    _exp2Controller.dispose();
    _sbase2Controller.dispose();
    _exp3Controller.dispose();
    _sbase3Controller.dispose();
    _exp4Controller.dispose();
    _sbase4Controller.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Firebase functionality removed
      // LinkModel.saveToFirebase(linkModel);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        validator: (value) {
          if (value == null) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Create Link')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  label: 'Title',
                  controller: _titleController,
                  hint: 'Enter title',
                ),
                _buildTextField(
                  label: 'Base URL',
                  controller: _baseUrlController,
                  hint: 'Enter base URL',
                ),
                _buildTextField(
                  label: 'Path',
                  controller: _pathController,
                  hint: 'Enter path',
                ),
                _buildTextField(
                  label: 'Sub-base URL',
                  controller: _subbaseUrlController,
                  hint: 'Enter sub-base URL',
                ),
                _buildTextField(
                  label: 'Registration',
                  controller: _regiController,
                  hint: 'Enter registration',
                ),
                _buildTextField(
                  label: 'Roll',
                  controller: _rollController,
                  hint: 'Enter roll',
                ),
                _buildTextField(
                  label: 'Year',
                  controller: _yearController,
                  hint: 'Enter year',
                ),
                _buildTextField(
                  label: 'Exp1',
                  controller: _exp1Controller,
                  hint: 'Enter exp1',
                ),
                _buildTextField(
                  label: 'Sbase1',
                  controller: _sbase1Controller,
                  hint: 'Enter sbase1',
                ),
                _buildTextField(
                  label: 'Regi1',
                  controller: _exp2Controller,
                  hint: 'Enter regi1',
                ),
                _buildTextField(
                  label: 'Roll1',
                  controller: _sbase2Controller,
                  hint: 'Enter roll1',
                ),
                _buildTextField(
                  label: 'Year1',
                  controller: _exp3Controller,
                  hint: 'Enter year1',
                ),
                _buildTextField(
                  label: 'Exp2',
                  controller: _exp2Controller,
                  hint: 'Enter exp2',
                ),
                _buildTextField(
                  label: 'Sbase2',
                  controller: _sbase2Controller,
                  hint: 'Enter sbase2',
                ),
                _buildTextField(
                  label: 'Regi2',
                  controller: _regiController2,
                  hint: 'Enter regi2',
                ),
                _buildTextField(
                  label: 'Roll2',
                  controller: _rollController2,
                  hint: 'Enter roll2',
                ),
                _buildTextField(
                  label: 'Year2',
                  controller: _yearController2,
                  hint: 'Enter year2',
                ),
                _buildTextField(
                  label: 'Exp3',
                  controller: _exp3Controller,
                  hint: 'Enter exp3',
                ),
                _buildTextField(
                  label: 'Sbase3',
                  controller: _sbase3Controller,
                  hint: 'Enter sbase3',
                ),
                _buildTextField(
                  label: 'Regi3',
                  controller: _regiController3,
                  hint: 'Enter regi3',
                ),
                _buildTextField(
                  label: 'Roll3',
                  controller: _rollController3,
                  hint: 'Enter roll3',
                ),
                _buildTextField(
                  label: 'Year3',
                  controller: _yearController3,
                  hint: 'Enter year3',
                ),
                _buildTextField(
                  label: 'Exp4',
                  controller: _exp4Controller,
                  hint: 'Enter exp4',
                ),
                _buildTextField(
                  label: 'Sbase4',
                  controller: _sbase4Controller,
                  hint: 'Enter sbase4',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
