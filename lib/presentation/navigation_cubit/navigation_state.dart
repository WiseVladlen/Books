part of 'navigation_cubit.dart';

enum PageViewType { favourite, search }

class NavigationState extends Equatable {
  const NavigationState({
    this.pageViewType = PageViewType.favourite,
  });

  final PageViewType pageViewType;

  @override
  List<Object> get props => <Object>[pageViewType];
}
