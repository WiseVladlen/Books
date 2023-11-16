import 'package:books/app/app.dart';
import 'package:books/domain/model/user_model.dart';
import 'package:books/domain/repository/repository.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesBloc>(
      create: (BuildContext context) => FavoritesBloc(
        bookRepository: context.read<IBookRepository>(),
        favoritesRepository: context.read<IFavoritesRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.appName),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                context
                    .read<NavigationBloc>()
                    .add(const AddToRootStackEvent(route: SearchPageRoute()));
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        drawer: const _Drawer(),
        body: Router<AppRoute>(
          routerDelegate: AbstractPageRouterDelegate<HomePageRoute>(
            bloc: context.read<NavigationBloc>(),
            navigatorKey: navigatorKey,
          ),
        ),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox.fromSize(
            size: const Size.fromHeight(208),
            child: DrawerHeader(
              decoration: BoxDecoration(color: context.colors.drawerBackground),
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BlocBuilder<UserAuthBloc, UserAuthState>(
                      builder: (BuildContext context, UserAuthState state) {
                        final UserModel? user = state.user;
                        return user != null
                            ? Text(
                                user.name,
                                style: context.textStyles.userInfoLarge,
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    BlocBuilder<UserAuthBloc, UserAuthState>(
                      builder: (BuildContext context, UserAuthState state) {
                        final UserModel? user = state.user;
                        return user != null
                            ? Text(
                                user.email,
                                style: context.textStyles.userInfoMedium,
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.l10n.appLanguageHeader),
            onTap: () => showLocaleSettingsModalBottomSheet(context),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: Text(context.l10n.themeModeHeader),
            onTap: () => showThemeModeSettingsModalBottomSheet(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(context.l10n.logOutHeader),
            onTap: () => showLogOutDialog(context),
          ),
        ],
      ),
    );
  }
}