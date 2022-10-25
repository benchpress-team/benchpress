$ROOT_PATH = $PSScriptRoot | split-path -parent | split-path -parent | split-path -parent | split-path -parent | split-path -parent

BeforeAll {
    Import-Module -Name $ROOT_PATH/Benchpress/Helpers/Azure/StorageAcccount.psm1
    Import-Module -Name $ROOT_PATH/Benchpress/Helpers/Azure/Bicep.psm1

    #arrange
    $resourceGroupName = 'rg-test-bicep'
    $storageAccountName = 'mystnamebicepv2'
}

Describe 'Spin up , Tear down Storage Account' {
    it 'Should deploy a bicep file.' {

        #arrange
        $bicepPath = "$ROOT_PATH/samples/dotnet/samples/pwsh/storageAccount.bicep"
        $params = @{
            name = "rg-test-bicep"
            location = "eastus"
        }

        #act
        $deployment = Deploy-BicepFeature $bicepPath $params $resourceGroupName

        #assert
        $deployment.ProvisioningState | Should -Be "Succeeded"
    }

    it 'Should Check Storage Sku Name'{

        #act
        $getStorageAccountSku = Get-StorageAccountSku $resourceGroupName $storageAccountName

        #assert
        $getStorageAccountSku | Should -Be "Standard_LRS"
    }

    it 'Should Check Storage Kind'{
        #act
        $getStorageAccountKind = Get-StorageAccountKind $resourceGroupName $storageAccountName

        #assert
        $getStorageAccountKind | Should -Be "StorageV2"
    }

    it 'Delete Deployed Resources'{
        Remove-BicepFeature $resourceGroupName
    }
}
