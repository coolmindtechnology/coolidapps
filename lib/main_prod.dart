import 'package:coolappflutter/data/networks/endpoint/api_endpoint.dart';
import 'package:coolappflutter/main.dart' as m;

/// Initializes the application by setting the API endpoint to production mode and
/// then calls the main function from the `m` module.
///
/// This function does not take any parameters.
///
/// It does not return anything.
void main() async {
  ApiEndpoint.setProd();
  m.main();
}
