// NOTA: El objetivo de este provider es poder establecer a lo largo de toda la palicación la
//       instancia del ProductsRepositoryImpl

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/infrastructure.dart';

final ProductsRepositoryProvider = Provider<ProductsRepository>((ref) {
  // NOTA: Como el ProductsDatasourceImpl necesita el accessToken el cual lo tenemos en otro provider, entre riverpod se pueden hablar mutuamente entre providers fácilmente gracias al ref
  //       Adicionalmente como puede ser nulo regresamos un string vacío.
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accessToken: accessToken),
  );

  return productsRepository;
});
