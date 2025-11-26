import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/provider/page_index_provider.dart';
import '../../provider/pages_provider.dart';

class CustomPageBuilder extends ConsumerStatefulWidget {
  const CustomPageBuilder({super.key});

  @override
  ConsumerState<CustomPageBuilder> createState() =>
      _CustomPageBuilderState();
}

class _CustomPageBuilderState
    extends ConsumerState<CustomPageBuilder> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(pageProvider);

    return PageView(
      controller: controller,
      children: pages,
      onPageChanged: (index) {
        ref
            .read(currentPageNotifierProvider.notifier)
            .setPage(index);
      },
    );
  }
}
