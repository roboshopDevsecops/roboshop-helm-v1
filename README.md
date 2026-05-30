# roboshop-helm-v1

Helm charts for Roboshop microservices, based on [wmp-helm-v2](https://github.com/raghudevopsb88/wmp-helm-v2).

## Services

| Values file | Service | Port |
|-------------|---------|------|
| `values/roboshop-cart.yml` | Cart API | 8080 |
| `values/roboshop-catalogue.yml` | Catalogue API | 8080 |
| `values/roboshop-user.yml` | User API | 8080 |
| `values/roboshop-payment.yml` | Payment API | 8080 |
| `values/roboshop-shipping.yml` | Shipping API | 8080 |
| `values/roboshop-ratings.yml` | Ratings API | 8080 |
| `values/roboshop-frontend.yml` | Web frontend (nginx) | 8080 |

## Install

```shell
make helm-install component=roboshop-cart
helm upgrade -i roboshop-cart . -f values/roboshop-cart.yml --set image_tag=<git-sha>
```

## AWS SSM parameters

All 42 parameters are hardcoded in `terraform/main.tf`. Edit values there, then apply:

```shell
cd terraform
make init
make apply
```

The `ssm-pull` init container reads parameters listed in each service's `PARAMS` value at deploy time.

## Database setup Jobs

Services with schema/master-data scripts run a Helm pre-install/pre-upgrade Job using a separate `-db` image:

| Service | DB type | Scripts |
|---------|---------|---------|
| roboshop-catalogue | MongoDB | `master-data.js` |
| roboshop-shipping | MySQL | `schema.sql`, `app-user.sql`, `master-data.sql` |
| roboshop-ratings | MySQL | `schema.sql`, `app-user.sql` |

Enable in values with:

```yaml
dbJob:
  enabled: true
  PARAMS: "MYSQL_HOST MYSQL_ROOT_PASSWORD"
```

Image: `349558942960.dkr.ecr.us-east-1.amazonaws.com/<service>-db:latest` (always pulled with `imagePullPolicy: Always`)
