import 'package:experience_server/src/endpoints/endpoint_extension.dart';
import 'package:experience_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CategoryEndpoint extends Endpoint {
  Future<List<Category>> getCategories(Session session) async {
    return onlyIfAuthenticated(session, (session) async {
      return Category.db
          .find(session, where: (table) => table.approved.equals(true));
    });
  }

  Future<Category?> getCategory(Session session, int id) async {
    return onlyIfAuthenticated(session, (session) async {
      return Category.db.findById(session, id);
    });
  }
}
