import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<Map<String, dynamic>> _users = [
    {'username': 'Naol Kumela', 'password': 'naol', 'role': 'user'},
    {'username': 'Abel Begashaw', 'password': 'abel', 'role': 'admin'},
    {'username': 'Milko Shuma', 'password': 'milko', 'role': 'user'},
    {'username': 'Natan Amanuel', 'password': 'natan', 'role': 'admin'},
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void _createUser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _users.add({
          'username': _newUsernameController.text,
          'password': _newPasswordController.text,
          'role': 'user', // New users start as regular users
        });
        _newUsernameController.clear();
        _newPasswordController.clear();
        Navigator.of(context).pop(); // Close the dialog
      });
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
                          setState(() {
                            _users.removeAt(index);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(user['role'] == 'admin'
                            ? Icons.person
                            : Icons.admin_panel_settings),
                        onPressed: () {
                          // Implement promote/demote user functionality here
                          setState(() {
                            user['role'] =
                                user['role'] == 'admin' ? 'user' : 'admin';
                          });
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
