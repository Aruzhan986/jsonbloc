import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_labour9/bloc/bloc_bloc.dart';
import 'package:flutter_labour9/bloc/bloc_event.dart';
import 'package:flutter_labour9/bloc/bloc_state.dart';
import 'package:flutter_labour9/repository.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository =
      UserRepository(baseUrl: 'https://jsonplaceholder.typicode.com');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => UserBloc(userRepository: userRepository),
        child: BottomNavBar(),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _ClassState createState() => _ClassState();
}

class _ClassState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    Work(),
    Games(),
    User(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Моя Bottom Bar App"),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.yellow,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.yellow,
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.work, size: 30),
          Icon(Icons.games, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lab91.json', width: 200, height: 200),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class Work extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lab92.json', width: 200, height: 200),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class Games extends StatelessWidget {
  final Random _random = Random();

  Color _getRandomColor() => Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UsersInitial) {
          BlocProvider.of<UserBloc>(context).add(FetchUsersEvent());
          return Center(child: CircularProgressIndicator());
        } else if (state is UsersLoaded) {
          final users = state.users;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                color: _getRandomColor().withOpacity(0.2),
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user['name']} (${user['username']})',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _getRandomColor()),
                      ),
                      SizedBox(height: 8),
                      Text('Email: ${user['email']}'),
                      Text('Phone: ${user['phone']}'),
                      Text('Website: ${user['website']}'),
                      Divider(color: _getRandomColor()),
                      Text('Company:'),
                      Text('Name: ${user['company']['name']}'),
                      Text('CatchPhrase: ${user['company']['catchPhrase']}'),
                      Text('BS: ${user['company']['bs']}'),
                      Divider(color: _getRandomColor()),
                      Text('Address:'),
                      Text('Street: ${user['address']['street']}'),
                      Text('Suite: ${user['address']['suite']}'),
                      Text('City: ${user['address']['city']}'),
                      Text('Zipcode: ${user['address']['zipcode']}'),
                      Text('Lat: ${user['address']['geo']['lat']}'),
                      Text('Lng: ${user['address']['geo']['lng']}'),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is UsersError) {
          return Center(child: Text(state.message));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Account"),
    );
  }
}
