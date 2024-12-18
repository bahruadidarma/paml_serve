import 'package:vania/vania.dart';
import 'package:paml_serve/app/http/controllers/customer_controller.dart';
import 'package:paml_serve/app/http/controllers/vendor_controller.dart';
import 'package:paml_serve/app/http/controllers/order_controller.dart';
import 'package:paml_serve/app/http/controllers/product_controller.dart';
import 'package:paml_serve/app/http/controllers/productnote_controller.dart';
import 'package:paml_serve/app/http/controllers/orderitem_controller.dart';
import 'package:paml_serve/app/http/controllers/auth_controller.dart';
import 'package:paml_serve/app/http/middleware/authenticate.dart';

class ApiRoute implements Route {
  @override
  void register() {
    Router.basePrefix('api');
    Router.group(() {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    }, prefix: 'auth');

    Router.group(() {
      // CUSTOMER
      Router.get("getCustomer", customerController.show);
      Router.post("postCustomer", customerController.store);
      Router.put("updateCustomer/{id}", customerController.update);
      Router.delete("deleteCustomer/{id}", customerController.destroy);

      // VENDOR
      Router.get("getVendor", vendorController.show);
      Router.post("postVendor", vendorController.store);
      Router.put("updateVendor/{id}", vendorController.update);
      Router.delete("deleteVendor/{id}", vendorController.destroy);

      // ORDER
      Router.get("getOrder", orderController.show);
      Router.post("postOrder", orderController.store);
      Router.put("updateOrder/{id}", orderController.update);
      Router.delete("deleteOrder/{id}", orderController.destroy);

      // PRODUCT
      Router.get("getProduct", productController.show);
      Router.post("postProduct", productController.store);
      Router.put("updateProduct/{id}", productController.update);
      Router.delete("deleteProduct/{id}", productController.destroy);

      // PRODUCT NOTE
      Router.get("getProductNote", productnoteController.show);
      Router.post("postProductNote", productnoteController.store);
      Router.put("updateProductNote/{id}", productnoteController.update);
      Router.delete("deleteProductNote/{id}", productnoteController.destroy);

      // ORDER ITEM
      Router.get("getOrderitem", orderitemController.show);
      Router.post("postOrderitem", orderitemController.store);
      Router.put("updateOrderitem/{id}", orderitemController.update);
      Router.delete("deleteOrderitem/{id}", orderitemController.destroy);
    }, prefix: 'user', middleware: [AuthenticateMiddleware()]);
  }
}
