import 'package:books/app/pages/home/home.dart';
import 'package:books/presentation/home/cubit/home_cubit.dart';
import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return Scaffold(
            body: state.bottomNavigationBarCurrentIndex == 0
                ? const FavouritesPage()
                : const SearchPage(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.bottomNavigationBarCurrentIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite_border),
                  label: context.l10n.favoritesLabel,
                  activeIcon: const Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  label: context.l10n.searchLabel,
                ),
              ],
              onTap: context.read<HomeCubit>().clickOnBottomNavigationBarItem,
            ),
          );
        },
      ),
    );
  }
}
