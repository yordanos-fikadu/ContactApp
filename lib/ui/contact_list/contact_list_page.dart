import 'package:flutter/material.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});
  @override
  Widget build(BuildContext context) {
    // List<Widget> contactlists = List.generate(
    //     100,
    //     (index) => Center(
    //       child: const Text(
    //             'Contact',
    //             style: TextStyle(fontSize: 30),
    //           ),
    //     ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return const Center(
            child: Text(
              'Contact',
              style: TextStyle(fontSize: 30),
            ),
          );
        },
      )),
    );
  }
}
