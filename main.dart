import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        //accentColor: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
        centerTitle: true,
      ),
      body: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool _isMale = false;
  bool _isFemale = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your name";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Name",
              hintText: "Enter your name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your email";
              }
              if (!isValidEmail(value)) {
                return "Invalid email format";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a password";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _isMale,
                onChanged: (value) {
                  setState(() {
                    _isMale = value ?? false;
                    _isFemale = false; // Uncheck female when selecting male
                  });
                },
              ),
              const Text('Male'),
              Checkbox(
                value: _isFemale,
                onChanged: (value) {
                  setState(() {
                    _isFemale = value ?? false;
                    _isMale = false; // Uncheck male when selecting female
                  });
                },
              ),
              const Text('Female'),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle form submission
              final FormState? formState = Form.of(context);
              if (formState != null && formState.validate()) {
                // Form is valid, proceed with submission
                print("Form submitted");
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}

bool isValidEmail(String value) {
  
  final pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    final regex = RegExp(pattern);
    return regex.hasMatch(value);
 
}
