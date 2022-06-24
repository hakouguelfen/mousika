import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      bottomNavigationBar: Skelton(
        width: double.maxFinite,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const MusicSkelton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Skelton(
                  width: 50,
                  height: 50,
                ),
                Skelton(
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: defaultPadding * 2),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: Skelton(
                      width: double.maxFinite,
                      height: 50,
                    ),
                  ),
                  SizedBox(width: defaultPadding * 0.5),
                  Expanded(
                    child: Skelton(
                      width: double.maxFinite,
                      height: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const MusicSkelton();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MusicSkelton extends StatelessWidget {
  const MusicSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skelton(
      margin: EdgeInsets.symmetric(
        vertical: defaultPadding * 0.1,
        horizontal: defaultPadding * 0.5,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
        ),
        leading: Skelton(
          width: 80,
          height: double.maxFinite,
        ),
        title: Skelton(width: 50, height: 10),
        subtitle: Skelton(width: 20, height: 10),
      ),
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    super.key,
    this.width,
    this.height,
    this.child,
    this.margin,
  });

  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(defaultBorderRaduis),
        border: Border.all(
          color: Theme.of(context).cardColor.withOpacity(0.5),
        ),
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
