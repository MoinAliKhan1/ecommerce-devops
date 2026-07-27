from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "application": "E-commerce Devops Project",
        "version": "1.0",
        "status": "Running"
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "up"
    }), 200

products = [
      {
          "id": 1,
          "name": "Laptop",
          "price": 65000,
          "stock": 10
      },
      {
          "id": 2,
          "name": "Keyboard",
          "price": 1200,
          "stock": 25
      },
      {
         "id": 3,
         "name": "Mouse",
         "price": 800,
          "stock": 40
      }
  ]


@app.route("/products")
def get_products():
    return jsonify(products)


@app.route("/products/<int:product_id>")
def get_product(product_id):

    for product in products:
        if product["id"] == product_id:
            return jsonify(product)

    return jsonify({
        "message": "Product not found"
    }), 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
