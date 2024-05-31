import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mind_twist/presentation/screens/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final newUsername = _usernameController.text.trim();
      final newPassword = _passwordController.text.trim();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('jwtToken');

        if (token != null) {
          final response = await http.put(
            Uri.parse('http://192.168.42.1:3000/api/auth/update'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(
              {'username': newUsername, 'password': newPassword},
            ),
          );

          if (response.statusCode == 200) {
            // Update successful
            // Update the user data in the local app for immediate effect
            prefs.setString('username', newUsername); // Update stored username
            // (You can also update the password if you are storing it locally)

            // Clear the controllers and navigate to the ProfilePage
            _usernameController.clear();
            _passwordController.clear();
            context.go('/profile');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
          } else {
            // Handle error
            final error = jsonDecode(response.body)['message'];
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error)),
            );
          }
        } else {
          // Token not found, handle accordingly
        }
      } catch (error) {
        // Handle network or other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      }
    }
  }

  Future<void> _deleteAccount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwtToken');

      if (token != null) {
        final response = await http.delete(
          Uri.parse('http://192.168.42.1:3000/api/auth/delete'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          // Account deleted successfully
          // Clear controllers (not necessary, but good practice)
          _usernameController.clear();
          _passwordController.clear();
          prefs.remove('jwtToken');
          prefs.remove('username'); // Remove stored username and password

          // Navigate back to the login screen or landing page
          context.go('/');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account deleted successfully')),
          );
        } else {
          // Handle error
          final error = jsonDecode(response.body)['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      } else {
        // Token not found, handle accordingly
      }
    } catch (error) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 120, 113, 170),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 158, 152, 199),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('assets/Images/profilepic.jpg'),
                  ),
                  const SizedBox(height: 20),
                  // Username Input Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: 'Enter new username',
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Password Input Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true, // Hide password text
                            decoration: InputDecoration(
                              hintText: 'Enter new password',
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _updateProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent.withOpacity(0.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: _deleteAccount,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor:
                                        Colors.transparent.withOpacity(0.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  //user can delete him/her self if need account no longer exist
                                  child: const Text(
                                    'Delete Account',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
