// TAREA: Este nuevo provider va a manejar un booleano llamado isDarkModePorvider

import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDarkmodeProvider = StateProvider<bool>((ref) => false);
