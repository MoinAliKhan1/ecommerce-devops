from flask import Blueprint, jsonify

from data import products, customers, orders
from config import APP_NAME, VERSION
from logger import logger
from utils import find_by_id

api = Blueprint("api", __name__)


@api.route("/")
def home():
    logger.info("Home API called")
    return jsonify({
        "application": APP_NAME,
        "version": VERSION,
        "status": "Running"
    })


@api.route("/health")
def health():
    logger.info("Health API called")
    return jsonify({"status": "up"})


@api.route("/products")
def get_products():
    logger.info("Products API called")
    return jsonify(products)


@api.route("/products/<int:product_id>")
def get_product(product_id):

    product = find_by_id(products, product_id)

    if product:
        return jsonify(product)

    return jsonify({"error": "Product not found"}), 404


@api.route("/customers")
def get_customers():
    return jsonify(customers)


@api.route("/customers/<int:customer_id>")
def get_customer(customer_id):

    customer = find_by_id(customers, customer_id)

    if customer:
        return jsonify(customer)

    return jsonify({"error": "Customer not found"}), 404


@api.route("/orders")
def get_orders():
    return jsonify(orders)


@api.route("/orders/<int:order_id>")
def get_order(order_id):

    order = find_by_id(orders, order_id)

    if order:
        return jsonify(order)

    return jsonify({"error": "Order not found"}), 404
