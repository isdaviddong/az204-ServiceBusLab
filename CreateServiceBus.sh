#use bash to run

myLocation="eastasia"
myResourceGroup="az204-svcbusdemo-rg"
az group create -n $myResourceGroup -l $myLocation

namespaceName=az204svcbus$RANDOM
az servicebus namespace create \
--resource-group $myResourceGroup \
--name $namespaceName \
--location $myLocation

az servicebus queue create --resource-group $myResourceGroup \
--namespace-name $namespaceName \
--name az204-queue

connectionString=$(az servicebus namespace authorization-rule keys list \
--resource-group $myResourceGroup \
--namespace-name $namespaceName \
--name RootManageSharedAccessKey \
--query primaryConnectionString --output tsv)
echo $connectionString