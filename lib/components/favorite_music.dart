import 'package:flutter/material.dart';
import 'package:music_play/screens/musicPlayer/music_player.dart';

class FavoriteMusic extends StatelessWidget {
  const FavoriteMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) => const MusicPlayer()),
              // );
            },
            child: Container(
              width: 200,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/images/arcade.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text('hola'),
              ),
            ),
          );
        },
      ),
    );
  }
}
