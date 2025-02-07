import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/auth/account_created_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class PivacyPolicyScreen extends StatelessWidget {
  final dynamic result;
  const PivacyPolicyScreen(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    final BaseRepository<Map<String, dynamic>> _userRepository =
    BaseRepository<Map<String, dynamic>>('users');
    return Scaffold(
      appBar:  buildCommonAppBar(context, 'Privacy Policy', isBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Update: 14/08/2024',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Praesent pellentesque congue lorem, vel tincidunt tortor '
                  'placerat a. Proin ac diam quam. Aenean in sagittis magna, ut '
                  'feugiat diam. Fusce a scelerisque neque, sed accumsan metus. \n\n'
                  'Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. '
                  'Aenean arcu metus, bibendum at rhoncus at, volutpat ut lacus. '
                  'Morbi pellentesque malesuada eros semper ultrices. Vestibulum '
                  'lobortis enim vel neque auctor, a ultrices ex placerat. Mauris ut '
                  'lacinia justo, sed suscipit tortor. Nam egestas nulla posuere '
                  'neque tincidunt porta.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            const Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '1. Ut lacinia justo sit amet lorem sodales accumsan. Proin '
                  'malesuada eleifend fermentum. Donec condimentum, nunc '
                  'at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros '
                  'est vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare '
                  'accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisi '
                  'posuere risus, vel facilisis nisi tellus ac turpis.\n\n'
                  '2. Ut lacinia justo sit amet lorem sodales accumsan. Proin '
                  'malesuada eleifend fermentum. Donec condimentum, nunc '
                  'at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros '
                  'est vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare '
                  'accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisi '
                  'posuere risus, vel facilisis nisi tellus.\n\n'
                  '3. Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Praesent pellentesque congue lorem, vel tincidunt tortor '
                  'placerat a. Proin ac diam quam. Aenean in sagittis magna, '
                  'ut feugiat diam.\n\n'
                  '4. Nunc auctor tortor in dolor luctus, quis euismod urna '
                  'tincidunt. Aenean arcu metus, bibendum at rhoncus at, '
                  'volutpat ut lacus. Morbi pellentesque malesuada eros '
                  'semper ultrices. Vestibulum lobortis enim vel neque auctor, '
                  'a ultrices ex placerat. Mauris ut lacinia justo, sed suscipit '
                  'tortor. Nam egestas nulla posuere neque.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _userRepository.update(result, {'isActive' : true});
                  navigate(context, AccountCreatedScreen(result));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF93000A),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Đồng ý',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}