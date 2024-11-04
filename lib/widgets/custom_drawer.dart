import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditationapp/providers/auth_proider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Drawer(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Color(0xFF4A3F8A),
            ),
          ),
          Positioned.fill(
            child: SparkelBackgroud(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 40),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: authProvider.user?.image != null
                        ? NetworkImage(authProvider.user!.image!)
                        : AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                  ),
                  SizedBox(height: 20),
                  Text(
                    authProvider.user?.username ?? "",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      print('Finished Exercises Clicked');
                    },
                    child: Text(
                      'Finished Exercises: ${authProvider.user?.finishedExercises}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFBEC3FF),
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    Divider(color: Color(0xFFBEC3FF), thickness: 1),
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        authProvider.logout();
                        context.go('/signin');
                      },
                      tileColor: Color(0xFF6A1B9A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SparkelBackgroud extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SparkleState();
}

class _SparkleState extends State<SparkelBackgroud>
    with SingleTickerProviderStateMixin {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 3), (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SparklePainter(_timer),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class SparklePainter extends CustomPainter {
  final Random random = Random();

  int tick = 0;
  Timer timer;

  SparklePainter(this.timer);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.7);
    final sparkleRadius = 2.0;

    // random sparkles
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), sparkleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    var should = timer.tick != tick;

    tick = timer.tick;

    return should;
  }
}
