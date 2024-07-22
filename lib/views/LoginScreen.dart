import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../utils/WidgetConfig.dart';
import '../animation/AnimationStyles.dart';
import '../notifiers/ThemeNotifier.dart';

class LoginScreen extends ConsumerStatefulWidget{
  const LoginScreen({super.key, required this.data});
  final String data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreen(data);
  }
}

class _LoginScreen extends ConsumerState<LoginScreen> with SingleTickerProviderStateMixin{
  _LoginScreen(this.data);
  final String data;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..forward();

    // Get the current theme from Riverpod
    final theme = ref.read(themeNotifierProvider);

    _animation = AnimationStyles.getAnimationForTheme(theme, _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Server Driven UI With $data',style: TextStyle(
          fontSize: 18
        ),),
      ),
      body: FutureBuilder<List<WidgetConfig>>(
        future: fetchWidgetConfig(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(padding: EdgeInsets.all(10),
            child:AnimationStyles.getAnimatedWidgetForTheme(theme, DynamicUIBuilder(widgetConfigs: snapshot.data!), _controller));
          }
        },
      ),
    );
  }

}

class DynamicUIBuilder extends StatelessWidget {
  final List<WidgetConfig> widgetConfigs;

  DynamicUIBuilder({required this.widgetConfigs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widgetConfigs.length,
      itemBuilder: (context, index) {
        final config = widgetConfigs[index];
        switch (config.type) {
          case 'text':
            return Text(config.text ?? '', style: TextStyle(color: Color(int.parse(config.color ?? '0xff000000'))));
          case 'button':
            return ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Color(int.parse(config.color ?? '0xff000000'))),
              child: Text(config.text ?? ''),
            );
            case 'image': {
            return Image.asset("assets/images/logo.png");}
            case 'sizebox':{
            return SizedBox(height: 5,);}
            case 'textfield':{
            return TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),
              hintText: config.text),
              style: TextStyle(),
            );}
          default:
            return Container();
        }
      },
    );
  }
}