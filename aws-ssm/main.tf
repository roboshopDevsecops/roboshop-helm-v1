terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-mkreddy-devmonkey"
    key    = "roboshop-awsssm/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ssm_parameter" "values" {
  count = length(var.inputs)
  name  = var.inputs[count.index].name
  type  = var.inputs[count.index].type
  value = var.inputs[count.index].value
}

variable "inputs" {
  default = [
    # roboshop-cart
    { name = "/roboshop-cart/REDIS_HOST", type = "String", value = "valkey.dev.roboshop.internal" },
    { name = "/roboshop-cart/CATALOGUE_HOST", type = "String", value = "roboshop-catalogue" },
    { name = "/roboshop-cart/CATALOGUE_PORT", type = "String", value = "8080" },
    { name = "/roboshop-cart/CART_SERVER_PORT", type = "String", value = "8080" },

    # roboshop-catalogue
    { name = "/roboshop-catalogue/MYSQL_HOST", type = "String", value = "mysql.dev.roboshop.internal" },
    { name = "/roboshop-catalogue/MYSQL_USER", type = "String", value = "catalogue" },
    { name = "/roboshop-catalogue/MYSQL_PASSWORD", type = "SecureString", value = "RoboShop@1" },
    { name = "/roboshop-catalogue/MYSQL_DATABASE", type = "String", value = "catalogue" },
    { name = "/roboshop-catalogue/CATALOGUE_SERVER_PORT", type = "String", value = "8080" },
    { name = "/roboshop-catalogue/MYSQL_ROOT_PASSWORD", type = "SecureString", value = "RoboShop@1" },

    # roboshop-user
    { name = "/roboshop-user/MONGO_URL", type = "SecureString", value = "mongodb://mongodb.dev.roboshop.internal:27017/users" },
    { name = "/roboshop-user/JWT_SECRET", type = "SecureString", value = "roboshop-secret-key" },
    { name = "/roboshop-user/USER_SERVER_PORT", type = "String", value = "8080" },

    # roboshop-payment
    { name = "/roboshop-payment/CART_HOST", type = "String", value = "roboshop-cart" },
    { name = "/roboshop-payment/CART_PORT", type = "String", value = "8080" },
    { name = "/roboshop-payment/USER_HOST", type = "String", value = "roboshop-user" },
    { name = "/roboshop-payment/USER_PORT", type = "String", value = "8080" },
    { name = "/roboshop-payment/AMQP_HOST", type = "String", value = "rabbitmq.dev.roboshop.internal" },
    { name = "/roboshop-payment/AMQP_USER", type = "String", value = "roboshop" },
    { name = "/roboshop-payment/AMQP_PASS", type = "SecureString", value = "RoboShop@1" },
    { name = "/roboshop-payment/SHOP_PAYMENT_PORT", type = "String", value = "8080" },

    # roboshop-shipping
    { name = "/roboshop-shipping/DB_HOST", type = "String", value = "mysql.dev.roboshop.internal" },
    { name = "/roboshop-shipping/DB_USER", type = "String", value = "shipping" },
    { name = "/roboshop-shipping/DB_PASS", type = "SecureString", value = "RoboShop@1" },
    { name = "/roboshop-shipping/PORT", type = "String", value = "8080" },
    { name = "/roboshop-shipping/MYSQL_ROOT_PASSWORD", type = "SecureString", value = "RoboShop@1" },

    # roboshop-ratings
    { name = "/roboshop-ratings/MYSQL_HOST", type = "String", value = "mysql.dev.roboshop.internal" },
    { name = "/roboshop-ratings/MYSQL_USER", type = "String", value = "ratings" },
    { name = "/roboshop-ratings/MYSQL_PASSWORD", type = "SecureString", value = "RoboShop@1" },
    { name = "/roboshop-ratings/MYSQL_DATABASE", type = "String", value = "ratings" },
    { name = "/roboshop-ratings/PORT", type = "String", value = "8080" },
    { name = "/roboshop-ratings/MYSQL_ROOT_PASSWORD", type = "SecureString", value = "RoboShop@1" },

    # roboshop-orders
    { name = "/roboshop-orders/MONGO_URL", type = "SecureString", value = "mongodb://mongodb.dev.roboshop.internal:27017/orders" },
    { name = "/roboshop-orders/AMQP_HOST", type = "String", value = "rabbitmq.dev.roboshop.internal" },
    { name = "/roboshop-orders/AMQP_USER", type = "String", value = "roboshop" },
    { name = "/roboshop-orders/AMQP_PASS", type = "SecureString", value = "RoboShop@1" },
    { name = "/roboshop-orders/SHIPPING_HOST", type = "String", value = "roboshop-shipping" },
    { name = "/roboshop-orders/SHIPPING_PORT", type = "String", value = "8080" },
    { name = "/roboshop-orders/PORT", type = "String", value = "8080" },

    # roboshop-frontend
    { name = "/roboshop-frontend/NGINX_PORT", type = "String", value = "8080" },
    { name = "/roboshop-frontend/CATALOGUE_HOST", type = "String", value = "roboshop-catalogue" },
    { name = "/roboshop-frontend/CATALOGUE_PORT", type = "String", value = "8080" },
    { name = "/roboshop-frontend/USER_HOST", type = "String", value = "roboshop-user" },
    { name = "/roboshop-frontend/USER_PORT", type = "String", value = "8080" },
    { name = "/roboshop-frontend/CART_HOST", type = "String", value = "roboshop-cart" },
    { name = "/roboshop-frontend/CART_PORT", type = "String", value = "8080" },
    { name = "/roboshop-frontend/SHIPPING_HOST", type = "String", value = "roboshop-shipping" },
    { name = "/roboshop-frontend/SHIPPING_PORT", type = "String", value = "8080" },
    { name = "/roboshop-frontend/PAYMENT_HOST", type = "String", value = "roboshop-payment" },
    { name = "/roboshop-frontend/PAYMENT_PORT", type = "String", value = "8080" },
    { name = "/roboshop-frontend/RATINGS_HOST", type = "String", value = "roboshop-ratings" },
    { name = "/roboshop-frontend/RATINGS_PORT", type = "String", value = "8080" },
    { name = "/roboshop-frontend/ORDERS_HOST", type = "String", value = "roboshop-orders" },
    { name = "/roboshop-frontend/ORDERS_PORT", type = "String", value = "8080" },
  ]
}
