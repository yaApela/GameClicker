import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/theme/theme_cubit.dart';
import 'package:prakticheskay4/cubit/home/home_cubit.dart';
import 'package:prakticheskay4/provider/themes.dart';

void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: context.read<ThemeCubit>().themeMode,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          home: MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      height: 700,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blueAccent,
                              width: 5,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20)),
                      child: Expanded(
                        child: BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Text(
                                    context.read<HomeCubit>().messages[index],
                                    style: TextStyle(
                                        color: Colors.lightGreen, fontSize: 16),
                                  ),
                                );
                              },
                              itemCount:
                              context.read<HomeCubit>().messages.length,
                            );
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is ClickState) {
                          count = state.clickCount;
                          return Text(
                            state.clickCount.toString(),
                            style: TextStyle(
                                color: Colors.lightGreen, fontSize: 50),
                          );
                        }
                        return Text(
                          '0',
                          style:
                          TextStyle(color: Colors.lightGreen, fontSize: 50),
                        );
                      },
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(
                          height: 65,
                          width: 165,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          child: TextButton(
                            onPressed: count <= 0
                                ? null
                                : () {
                              context.read<HomeCubit>().handleMinus(
                                  context.read<ThemeCubit>().themeMode);
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 65,
                          width: 165,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          child: TextButton(
                            onPressed: () {
                              context.read<HomeCubit>().handlePlus(
                                  context.read<ThemeCubit>().themeMode);
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 65,
                          width: 165,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          child: TextButton(
                            onPressed: () {
                              if (superTema == false) {
                                superTema = true;
                              } else if (superTema == true) {
                                superTema = false;
                              }
                              context.read<HomeCubit>().handleAuto(
                                  context.read<ThemeCubit>().themeMode);
                            },
                            child: const Text("AUTO",
                                style: TextStyle(color: Colors.black, fontSize: 15)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 65,
                          width: 165,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          child: TextButton(
                            onPressed: () {
                              if(count >= 30)
                              {
                                count -= 30;
                                context.read<HomeCubit>().handleUpgrade();
                              }
                            },
                            child: const Text("Upgrade - 30",
                                style: TextStyle(color: Colors.black, fontSize: 15)),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<ThemeCubit>().changeTheme();
              context.read<HomeCubit>().themeSwitched(context);
            },
            child: Icon(state is LightThemeState
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
          );
        },
      ),
    );
  }
}
