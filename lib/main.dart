import 'package:flutter/material.dart';
import 'package:flutter_project_test/check_box_model.dart';
import 'package:provider/provider.dart';

import 'check_box_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => CheckBoxModel(),
        child: const Scaffold(
          body: Main(),
        ),
      ),
    );
  }
}


class Main extends StatelessWidget {
  const Main({super.key});


  @override
  Widget build(BuildContext context) {
    final model = context.read<CheckBoxModel>();
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        const SliverSafeArea(sliver: SliverListWidget()),
        const SliverToBoxAdapter(
          child: AnimationDurationWidget(),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    model.addCheckBoxes();
                  },
                  child: const Text(
                    'Add checkboxes',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    model.removeCheckBoxes();
                  },
                  child: const Text(
                    'Remove checkboxes',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ]),
        ),
      ],
    );
  }
}

class AnimationDurationWidget extends StatefulWidget {
  const AnimationDurationWidget({
    super.key,
  });

  @override
  State<AnimationDurationWidget> createState() =>
      _AnimationDurationWidgetState();
}

class _AnimationDurationWidgetState extends State<AnimationDurationWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<CheckBoxModel>();
    return Column(
      children: [
        const Text('Animation duration'),
        const SizedBox(
          height: 15,
        ),
        Slider(
          activeColor: Colors.red,
          inactiveColor: Colors.red[200],
          onChanged: (value) {
            model.animationDuration = value.roundToDouble();
            setState(() {});
          },
          value: model.animationDuration,
          min: 200,
          max: 1500,
        ),
        const SizedBox(
          height: 15,
        ),
        Text('${model.animationDuration.toInt()} ms'),
      ],
    );
  }
}

class SliverListWidget extends StatelessWidget {
  const SliverListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CheckBoxModel>();
    final checkBoxList = model.checkBoxList;
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((
        context,
        index,
      ) {
        if (checkBoxList.isEmpty) return Container();
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CheckBoxWidget(
              color: checkBoxList[index].color,
              isCheck: checkBoxList[index].isCheck,
              index: index,
            ),
          ),
        );
      }, childCount: checkBoxList.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, mainAxisSpacing: 16),
    );
  }
}
