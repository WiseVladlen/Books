import 'package:books/app/pages/home/home.dart';
import 'package:books/presentation/navigation_cubit/navigation_cubit.dart';
import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (BuildContext context, NavigationState state) {
          return Scaffold(
            body: switch (state.pageViewType) {
              PageViewType.favourite => const FavouritesPage(),
              PageViewType.search => const SearchPage(),
            },
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.pageViewType.index,
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
              onTap: (int index) => context.read<NavigationCubit>().clickOnPage(index: index),
            ),
          );
        },
      ),
    );
  }
}
