az storage account create \
  --kind StorageV2 \
  --resource-group learn-65cf1043-4a26-4c6c-9dc0-acc00341bc94 \
  --location centralus \
  --name [your-unique-storage-account-name]


  # The following is the typical workflow for apps that use Azure Blob storage:
  # 1. Retrieve configuration: At startup, load the storage account configuration. This is typically a storage account connection string.
  # 2. Initialize client: To initialize the Azure Storage client library, use the connection string. This creates the objects the app will use to work with the Blob storage API.
  # 3. Use: To operate on containers and blobs, make API calls with the client library.


az appservice plan create --name blob-exercise-plan --resource-group learn-65cf1043-4a26-4c6c-9dc0-acc00341bc94 --sku FREE --location centralus
az webapp create --name stacct23640 --plan blob-exercise-plan --resource-group learn-65cf1043-4a26-4c6c-9dc0-acc00341bc94
CONNECTIONSTRING=$(az storage account show-connection-string --name me27292 --output tsv)
az webapp config appsettings set --name stacct23640 --resource-group learn-65cf1043-4a26-4c6c-9dc0-acc00341bc94 --settings AzureStorageConfig:ConnectionString=$CONNECTIONSTRING AzureStorageConfig:FileContainerName=files

dotnet publish -o pub
cd pub
zip -r ../site.zip *
az webapp deployment source config-zip --src ../site.zip --name stacct23640 --resource-group learn-65cf1043-4a26-4c6c-9dc0-acc00341bc94