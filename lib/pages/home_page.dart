import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditationapp/providers/auth_proider.dart';
import 'package:meditationapp/providers/theme_provider.dart';
import 'package:meditationapp/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _allItems = [
    'Meditation Tips',
    'Meditation Music',
    'Meditation',
    'Yoga'
  ]; // Example items

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            color:
                themeProvider.isDarkTheme ? Colors.white : Color(0xFF848484)),
      ),
      body: _buildContent(context, themeProvider),
    );
  }

  Widget _buildContent(BuildContext context, ThemeProvider themeProvider) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: themeProvider.isDarkTheme
              ? [Colors.black, Colors.grey[900]!]
              : [Color(0xFF8990FF), Color(0xFFE0E7FF)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_getGreeting()},${authProvider.user?.username}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkTheme
                    ? Colors.white
                    : Color(0xFFDDDDDD),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color:
                    themeProvider.isDarkTheme ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(40.0),
                boxShadow: [
                  BoxShadow(
                    color: themeProvider.isDarkTheme
                        ? Colors.black45
                        : Colors.grey.withOpacity(0.3),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: themeProvider.isDarkTheme
                          ? Colors.white70
                          : Colors.black),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(Icons.search,
                        color: themeProvider.isDarkTheme
                            ? Colors.white70
                            : Colors.grey),
                  ),
                ),
                style: TextStyle(
                  color:
                      themeProvider.isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: _allItems.map((item) {
                  String imagePath;
                  switch (item) {
                    case 'Meditation Tips':
                      imagePath = 'assets/images/read.png';
                      break;
                    case 'Meditation Music':
                      imagePath = 'assets/images/music.png';
                      break;
                    case 'Meditation':
                      imagePath = 'assets/images/meditation.png';
                      break;
                    case 'Yoga':
                      imagePath = 'assets/images/yoga.png';
                      break;
                    default:
                      imagePath = 'assets/images/yoga.png';
                  }

                  return GestureDetector(
                    onTap: () {
                      switch (item) {
                        case 'Meditation Tips':
                          context.push('/tips');
                          break;
                        case 'Meditation Music':
                          context.push('/music');
                          break;
                        case 'Meditation':
                          context.push('/meditation');
                          break;
                        case 'Yoga':
                          context.push('/exercises');
                          break;
                        default:
                          print("Route not found for item: $item");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 4,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
