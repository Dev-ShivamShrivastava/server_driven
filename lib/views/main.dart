import 'package:customer_demo/views/LoginScreen.dart';
import 'package:customer_demo/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/ThemeNotifier.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ),);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const MyHomePage(title: 'Customer App Demo'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,

        title: Text(title,style: TextStyle(color: Colors.white),),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(4, (index){
          return GestureDetector(
            onTap: ()=>{
              if(index==0){
                themeNotifier.setTheme(theme1),
              }else if(index == 1){
                themeNotifier.setTheme(theme2),
              }else if(index == 2){
                themeNotifier.setTheme(theme3),
              }else if(index == 3){
                themeNotifier.setTheme(theme4),
              }else{
                themeNotifier.setTheme(theme1),
              },
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(data:"Theme $index",)))
            },
            child: Card(
              color: index==0 ?Colors.blue : index==1 ? Colors.green :index==2 ? Colors.cyan:Colors.pink,
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text("Theme $index",style: TextStyle(fontSize: 18.0,color: Colors.white),),
              ),
            ),
          );
        }),),
    );
  }
}

