class Config {
  static const String appName = "Amazon Clone";
  static const String apiURL = "10.0.2.2:4000";
  static const registerAPI = "/api/register";
  static const loginAPI = "/api/login";
  static const verifyToken = "/tokenValidity";
  static const publishProduct = "/admin/add-product";
  static const getProducts = "/admin/get-products";
  static const deleteProduct = "/admin/delete-product";
  static const products = "/api/products";
  static const searchProducts = "/api/products/search";
  static const productRating = "/api/product/rate";
  static const dealOfTheDay = "/api/top-deal";
  static const addToCart = "/api/add-to-cart";
  static const removeFromCart = "/api/remove-from-cart";
  static const saveDeliveryAddress = "/api/save-delivery-address";
  static const placeOrder = "/api/place-order";
  static const userOrders = "/api/orders/me";
  static const getAllOrders = "/admin/get-orders";
  static const updateOrdersStatus = "/admin/update-order-status";
  static const getSalesAnalytics = "/admin/get-total-sales";
}
