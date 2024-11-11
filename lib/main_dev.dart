import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/main.dart' as m;

void main() async {
  /// Initializes the application by setting the API endpoint to development mode and
  /// then calls the main function from the `m` module.
  ///
  /// This function does not take any parameters.
  ///
  /// It does not return anything.
  ApiEndpoint.setDev();

  m.main();
}
