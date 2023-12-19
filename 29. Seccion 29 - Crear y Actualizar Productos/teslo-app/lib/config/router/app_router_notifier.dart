// NOTA: Este es nuestro ChangeNotifier que nos va a apoyar para el manejo del refreshListenable en nuestro provider de las rutas.
//       Otra cosa es que al hacerlo de esta forma es que vamos a tener algo sencillo que podemos usar con bloc, getex, riverpod, cubits,
//       etc, es decir, no va a importar que gestor de estado tengamos va a ser la misma mecánica y va a funcionar para cualquiera.
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

// NOTA: Ocupamos proveer el notifier que creamos mediante de riverpod
final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

// Cr4eamos el Notifier
class GoRouterNotifier extends ChangeNotifier {
  // NOTA: Vamos a pedir una instancia del AuthNotifier el cual podría ser una instancia del bloc o del cubit, o del provider, clase reactiva de getx, lo que sea
  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;

  // NOTA: Mediante el constructor pasamos el _authNotifier adicionalmente en todo momento yo debo estar pendiente de los cambios que el authNotifier tenga
  //       y para esto colocamos un listener. Entonces cuando ese authNotifier haga un cambio en el estado necesitamos reaccionar a ese estados
  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  // NOTA: Cuando yo cambie el estado automáticamente va a notificar al router
  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
