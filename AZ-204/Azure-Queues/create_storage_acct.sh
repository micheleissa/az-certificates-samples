#!/bin/bash
az storage account create --name mestorage85 -g <rg-name> --kind StorageV2 --sku Standard_LRS -l <location>

az storage account show-connection-string --name <name> --resource-group <rg-name>