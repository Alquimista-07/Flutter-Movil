# cinemapedia

# Dev

1. Copiar el .env.template y renombrarlo a .env
2. Crear o iniciar sesión en una cuenta en [TheMovieDB](https://www.themoviedb.org/)
3. En el perfil de usuario ir al apartado de ajustes o configuración.
4. En el panel izquiero ir a la sección API.
5. Generar o solicitar una nueva clave de la API en caso de que no se cuente con una.
6. En el archivo .env colocar la clave de la API generada en la variable de entorno llamada THE_MOVIEDB_KEY
7. Adicionalmente como trabajamos con una base de datos local para almacenar los favoritos (Isar Database), por lo tanto es necesario ejecutar el comando:
```
flutter pub run build_runner build
```

### NOTA: 
La documentación de TheMovieDB la encontramos en:
[TheMovieDB-Developers](https://developer.themoviedb.org/docs/getting-started)
La documentación de Isar Database la encontramos en: [Isar](https://isar.dev/es/tutorials/quickstart.html)


# Producción

Para cambiar el nombre de la aplicación:
Documentación del paquete: [change_app_package_name](https://pub.dev/packages/change_app_package_name/install)
```
flutter pub run change_app_package_name:main com.thealchemist.cinemapedia
```