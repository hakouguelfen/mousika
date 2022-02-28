import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      bottomNavigationBar: const Skelton(
        width: double.maxFinite,
        height: 80,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),
              const Skelton(width: 150),
              SizedBox(height: height * 0.03),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Skelton(width: 200, height: 200),
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.03),
              const Skelton(width: 150),
              SizedBox(height: height * 0.03),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 0.5,
                      ),
                      child: Skelton(
                        width: double.maxFinite,
                        height: height * 0.1,
                      ),
                    );
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

class Skelton extends StatelessWidget {
  const Skelton({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(defaultBorderRaduis),
      ),
      width: width,
      height: height,
    );
  }
}
