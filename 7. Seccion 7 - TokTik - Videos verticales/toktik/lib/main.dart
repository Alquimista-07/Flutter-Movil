import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Envolvemos en el Multiprovider y le pasamos el o los providers. Esto se explico en la aplicación anterior (YesNoApp)
    return MultiProvider(
      providers: [
        // NOTA: Una cosa que tenemos que tener en cuenta de estos ChangeNotifierProvider es que por defecto su comportamiento natural
        //       es que hasta que es necesario Provider va a crear esta instancia, es decir, son cargados de forma peresosa por defecto
        //       y si queremos omitir ese comportamiento por defecto y que sea cargado tan pronto se cree la referencia  al Provider
        //       (DiscoverProvider) se lance el constructor o sea se cree la instancia, y esto podría ser conveniente si nosotros tenemos
        //       un proceso que sabemos que el usuario va a llegar ahí pero todavía no, por ejemplo una carga asincrona da deata que el
        //       usuario eventualmente va a necesitar.
        ChangeNotifierProvider(
          lazy: false,
          // NOTA: Cuando indicamos el .. a eso se le conoce como un operador de cascada y esto es algo genial que tiene
          //       Dart ya que en luegar de colocar mi objeto punto y el método y luego nuevamente el objeto punto el método
          //       simplemte definimos el objeto y hacemos punto punto y el métoto nuevemente punto punto y el otro método.
          //       El ejemplo e ilustración de esto se encuentra en la hoja de atajos de Dart entregada por Fernando en la
          //       sección 1
          create: (_) => DiscoverProvider()..loadNextPage(),
        )
      ],
      child: MaterialApp(
          title: 'TokTik',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().getTheme(),
          home: const DiscoverScreen()),
    );
  }
}
