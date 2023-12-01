import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2(
    this.first,
    this.second, {
    Key? key,
    required this.builder,
    required this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget child;
  final Widget Function(BuildContext context, A a, B b, Widget child) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (_, a, __) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, b, __) {
            return builder(context, a, b, child);
          },
        );
      },
    );
  }
}*/

class ValueListenableBuilder3<A, B, C> extends StatelessWidget {
  const ValueListenableBuilder3(
    this.first,
    this.second,
    this.third, {
    Key? key,
    required this.builder,
    required this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final ValueListenable<C> third;

  final Widget child;
  final Widget Function(BuildContext context, A a, B b, C c, Widget child)
      builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (_, a, ___) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, b, ___) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (___, c, _) {
                return builder(context, a, b, c, child);
              },
            );
          },
        );
      },
    );
  }
}
