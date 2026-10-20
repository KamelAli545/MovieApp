import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/cubit/auth_cubit.dart';
import 'package:movieapp/cubit/savedServices.dart';
import 'package:movieapp/model/Results.dart';
import 'package:movieapp/screens/savedScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      backgroundColor: const Color(0xFF242A32),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              accountName: Text(
                user?.displayName ?? 'Guest',
                style: const TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                user?.email ?? '',
                style: const TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Color(0xFF4329F9)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 10,),
            StreamBuilder<List<Movie>>(
              stream: SavedService().watchSaved(),
              builder: (context, snap) {
                final hasSaved = (snap.data?.isNotEmpty ?? false);
                return ListTile(
                  leading: Icon(
                    hasSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                  title: const Text('Saved Movies', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SavedScreen()),
                    );
                  },
                );
              },
            ),            const Spacer(),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log out', style: TextStyle(color: Colors.red)),
              onTap: () async {
                final navigator = Navigator.of(context);
                final auth = context.read<AuthCubit>();

                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    backgroundColor:Color(0xFF242A32),
                    title: const Text('Log out',
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                    content: const Text('Are you sure you want to log out?',
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                        style: TextButton.styleFrom(foregroundColor: Colors.red),
                        child: const Text('Log out',
                        style: TextStyle(
                          color: Colors.red
                        ),
                        ),
                      ),
                    ],
                  ),
                );
                if (confirmed != true) return;
                navigator.popUntil((route) => route.isFirst);
                await auth.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}