help:      ## Print this message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
frontend:  ## Install Frontend component
	@bash frontend.sh
catalogue: ## Install Catalogue component
	@bash catalogue.sh
cart:      ## Install Cart component
	@bash cart.sh
user:      ## Install User component
	@bash user.sh
shipping:  ## Install Shipping component
	@bash shipping.sh
payment:   ## Install Payment component
	@bash payment.sh
mongodb:   ## Install MongoDB component
	@bash mongodb.sh
redis:     ## Install Redis component
	@bash redis.sh
mysql:     ## Install MySQL component
	@bash mysql.sh
rabbitmq:  ## Install Rabbitmq component
	@bash rabbitmq.sh
databases: mongodb redis mysql rabbitmq  ## Install all Databases

