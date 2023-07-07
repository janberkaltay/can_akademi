import 'package:can_mobil/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();

  const NavBar({Key? key}) : super(key: key);
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFA000),
      child: Column(
        children: [
          Container(
            height: 30,
            color: Colors.white,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 8, top: 8),
            height: 80,
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(0xFFFFA000),
                  backgroundImage: AssetImage('assets/Can logo.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 80),
                  child: Text(
                    'Menü',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Eğitim Kadrosu',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: const Text('Hakkımızda',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Konum',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 16),
                      height: 38,
                      width: 110,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'İletişim',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFA000),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        const instagram =
                            'https://www.instagram.com/canakademiadana/';
                        await launch(instagram);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.pinkAccent,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        const whatsapp = 'https://wa.me/05528167901';
                        await launch(whatsapp);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                        size: 36,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        const facebook =
                            'https://www.facebook.com/canakademiadana';
                        await launch(facebook);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blueAccent,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  Icons.copyright,
                  size: 20,
                  color: Color(0xFFFFA000),
                ),
                TextButton(
                    onPressed: () async {
                      const facebook =
                          'https://www.linkedin.com/company/endless-software/';
                      await launch(facebook);
                    },
                    child: const Text(
                      'Powered By Endless Software',
                      style: TextStyle(
                        color: Color(0xFFFFA000),
                      ),
                    ))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
