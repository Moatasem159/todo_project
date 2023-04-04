import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Cubit/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:todo/Cubit/bottom_nav_cubit/bottom_nav_state.dart';
import 'package:todo/Cubit/ThemeCubit.dart';
import 'package:todo/widgets/create_button.dart';
import 'package:todo/widgets/custom_bottom_nav.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit,BottomNavStates>(
      builder: (context, state) {
        BottomNavCubit cubit=BottomNavCubit.get(context);
        return  Scaffold(
          key: cubit.scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.title[cubit.current]),
            automaticallyImplyLeading: false,
            actions: [
              cubit.isBottomSheetShown?
              Container(): IconButton(
                  splashRadius: 20,
                  icon: ThemeCubit.get(context).icon,
                  onPressed:(){
                    ThemeCubit.get(context).changeThemeMode();
                  })
            ],
          ),
          body: cubit.screens[cubit.current],
          bottomNavigationBar: CustomBottomNav(
                index: cubit.current,
                onTap: (value) {
                  cubit.changeIndex(value);
                },
              ),
          floatingActionButton: CreateButton()
        );
      },
    );
  }
}