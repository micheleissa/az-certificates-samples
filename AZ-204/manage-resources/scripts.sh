export RESOURCE_GROUP=learn-35c1d9b3-c6b8-4b26-817d-0aa3a1c4fcbe
export AZURE_REGION=centralus
export AZURE_APP_PLAN=popupappplan-$RANDOM
export AZURE_WEB_APP=popupwebapp-$RANDOM

# list az groups in current subscription
az group list --output table

# filter the list based on a specific value via JMESPath
az group list --query "[?name == '$RESOURCE_GROUP']"

# Provision/create a service plan for web app
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE

# Verify service plan was created successfully
az appservice plan list --output table

# Create a web app
az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN

# Verify web app was created successfully
az webapp list --output table

# Deploy Github repo into the web app
az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration

#Check the deployed web app using curl
curl $AZURE_WEB_APP.azurewebsites.net

