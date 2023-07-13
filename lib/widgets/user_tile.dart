import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isNull || user.avatarUrl.isUndefinedOrNull
        ? CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl!),
          );

    final userProvider = Provider.of<UsersProvider>(context, listen: false);

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.user_form, arguments: user);
                },
                icon: Icon(
                  Icons.edit_document,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Exclusão'),
                      content: Text('Tem certeza?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Não'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            userProvider.remove(user);
                            Navigator.of(context).pop();
                          },
                          child: Text('Sim'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
