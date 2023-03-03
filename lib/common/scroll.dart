
import 'package:flutter/widgets.dart';

bool scrollIsBottom(ScrollController scrollController){
  if (!scrollController.hasClients) return false;
  final maxScroll = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.offset;
  return currentScroll >= (maxScroll * 0.9);
}