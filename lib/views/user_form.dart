import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;

    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuario'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final bool isValid = _form.currentState?.validate() ?? false;

              if (isValid) {
                _form.currentState?.save();
                Provider.of<UsersProvider>(context, listen: false).put(User(
                  id: _formData['id'],
                  name: _formData['name']!,
                  email: _formData['email']!,
                  avatarUrl: _formData['avatarUrl'],
                ));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  initialValue: _formData['name'],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O campo deve ser preenchido';
                    }

                    if (value.trim().length <= 4) {
                      return 'O campo deve ter pelo menos 5 caracteres';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  initialValue: _formData['email'],
                  onSaved: (value) => _formData['email'] = value!,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O campo deve ser preenchido';
                    }

                    if (value.trim().length <= 4) {
                      return 'O campo deve ter pelo menos 5 caracteres';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'URL do Avatar'),
                  initialValue: _formData['avatarUrl'],
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O campo deve ser preenchido';
                    }

                    if (value.trim().length <= 4) {
                      return 'O campo deve ter pelo menos 5 caracteres';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
