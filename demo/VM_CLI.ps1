# https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli

az account set --subscription RIM_Azure_Internal_Test_env
az group create --name RG-AZ104-VM-DemoCLI --location eastus

az vm create \
    --resource-group RG-AZ104-VM-DemoCLI \
    --name az104cli \
    --image Win2019Datacenter \
    --public-ip-sku Standard \
    --admin-username azureuser 