import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> _users = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwtToken');

    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse('http://192.168.42.1:3000/api/admin/users'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> usersData = jsonDecode(response.body);
          setState(() {
            _users =
                usersData.map((user) => user as Map<String, dynamic>).toList();
          });
        } else {
          print('Failed to load users');
        }
      } catch (error) {
        print('Error fetching users: $error');
      }
    }
  }

  Future<void> _createUser() async {
    if (_formKey.currentState!.validate()) {
      final newUsername = _newUsernameController.text.trim();
      final newPassword = _newPasswordController.text.trim();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwtToken');

      if (token != null) {
        try {
          final response = await http.post(
            Uri.parse('http://192.168.42.1:3000/api/auth/signup'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(
              {'username': newUsername, 'password': newPassword},
            ),
          );

          if (response.statusCode == 201) {
            _fetchUsers();
            _newUsernameController.clear();
            _newPasswordController.clear();
            context.pop();
          } else {
            final error = jsonDecode(response.body)['message'];
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error)),
            );
          }
        } catch (error) {
          print('Error creating user: $error');
        }
      }
    }
  }

  Future<void> _updateUserRole(String userId, String newRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwtToken');

    if (token != null) {
      try {
        final response = await http.put(
          Uri.parse('http://192.168.42.1:3000/api/admin/users/$userId/role'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({'role': newRole}),
        );

        if (response.statusCode == 200) {
          _fetchUsers();
        } else {
          final error = jsonDecode(response.body)['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      } catch (error) {
        print('Error updating user role: $error');
      }
    }
  }

  Future<void> _deleteUser(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwtToken');

    if (token != null) {
      try {
        final response = await http.delete(
          Uri.parse('http://192.168.42.1:3000/api/admin/users/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          _fetchUsers();
        } else {
          final error = jsonDecode(response.body)['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      } catch (error) {
        print('Error deleting user: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Panel',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 158, 152, 199),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              // Use ListView.separated for dividers
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  tileColor: const Color.fromARGB(
                      255, 158, 152, 199), // Set tile color
                  title: Text(user['username']),
                  subtitle: Text('Role: ${user['role']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Implement delete user functionality here
                          _deleteUser(user['_id']);
                        },
                      ),
                      IconButton(
                        icon: Icon(user['role'] == 'admin'
                            ? Icons.person
                            : Icons.admin_panel_settings),
                        onPressed: () {
                          // Implement promote/demote user functionality here
                          _updateUserRole(user['_id'],
                              user['role'] == 'admin' ? 'user' : 'admin');
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[800], // Customize divider color
                thickness: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Create User'),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _newUsernameController,
                              decoration:
                                  const InputDecoration(hintText: 'Username'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a username';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _newPasswordController,
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _createUser,
                          child: const Text('Create'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Create User'),
            ),
          ),
        ],
      ),
    );
  }
}
