import 'dart:io';
import 'package:contacts/models/contact_model.dart';
import 'package:contacts/pages/contact_home.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:contacts/utils/constant.dart';
import 'package:contacts/utils/helper_funtion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewContact extends StatefulWidget {
  static const String routeName = '/new';

  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _webController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? _selectedDate;
  String? _group;
  Gender? gender;

  String? _imagePath;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact '),
        actions: [IconButton(onPressed: _save, icon: const Icon(Icons.save))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
          children: [
            Column(
              children: [
                Card(
                    elevation: 5.0,
                    child: _imagePath == null ? const Icon(
                      Icons.person, size: 100,)
                        : Image.file(File(_imagePath!), width: 100,
                      height: 100,
                      fit: BoxFit.cover,)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(onPressed: () {
                      _getImage(ImageSource.camera);
                    },
                      label: const Text('Capture'),
                      icon: const Icon(Icons.camera),),
                    OutlinedButton.icon(onPressed: () {
                      _getImage(ImageSource.gallery);
                    },
                      label: const Text('Gallery'),
                      icon: const Icon(Icons.photo),),
                  ],

                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Contact Name(required)',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a contact name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _mobileController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Mobile Number(required)',
                  prefixIcon: Icon(Icons.call),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a mobile number ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address(required)',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide an email address ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Street Address(required)',
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a street address ';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: TextFormField(
                controller: _webController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'WebSite (optional)',
                  prefixIcon: Icon(Icons.web),
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _SelectDateofBirth,
                      child: const Text('Select date of birth'),
                    ),
                    Text(_selectedDate == null
                        ? 'No date chosen'
                        : getFormattedDate(_selectedDate!)!)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      border: InputBorder.none
                  ),
                  isExpanded: true,
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Please select a group';
                    }
                    return null;
                  },
                  value: _group,
                  hint: const Text('Select Group'),
                  items: groups
                      .map((group) =>
                      DropdownMenuItem(
                        value: group,
                        child: Text(group),
                      ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _group = value;
                    });
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Select Gender '),
            ),
            Row(
              children: [
                Radio<Gender>(
                    value: Gender.Male, groupValue: gender, onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                }),
                Text(Gender.Male.name),
                Radio<Gender>(value: Gender.Female,
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    }),
                Text(Gender.Female.name),

              ],

            )
          ],
        ),
      ),
    );
  }

  void _save() {
    if (gender == null) {
      showMsg(context, 'Please select your gender ');
      return;
    }
    if (_formKey.currentState!.validate()) {
      final contact = ContactModel(
          name: _nameController.text,
          mobile: _mobileController.text,
          email: _emailController.text,
          address: _addressController.text,
          website: _webController.text.isEmpty ? null : _webController.text,
          group: _group!,
          gender: gender!.name,
          image: _imagePath,
          dob: getFormattedDate(_selectedDate));

context.read<ContactProvider>().addContact(contact)
    .then((value ){
      showMsg(context, 'Saved');
      Navigator.pushNamed(context, ContactHome.routeName);
}).   catchError((error){
    showMsg(context, error.toString());
    });

    }

  }

  void _SelectDateofBirth() async {
    final date = await showDatePicker(
        context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      setState(() {
        _imagePath = xFile.path;
      });
    }
  }
}
