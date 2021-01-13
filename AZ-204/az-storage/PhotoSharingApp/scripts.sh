storagename=name
rg=<rg-name>
loc=southcentralus
az storage account create \
    --name $storagename \
    --resource-group $rg \
    --location $loc \
    --sku Standard_LRS \


################# REST API endpoints #######################
#The REST endpoint is a combination of your storage account name, the data type, and a known domain. For example:

#               REST API ENDPOINT
#               Data type	Example endpoint
#               Blobs	https://[name].blob.core.windows.net/
#               Queues	https://[name].queue.core.windows.net/
#               Table	https://[name].table.core.windows.net/
#               Files	https://[name].file.core.windows.net/

az storage account show-connection-string \
    --resource-group $rg \
    --name $storage \
    --query connectionString

az storage container list --account-name <name>