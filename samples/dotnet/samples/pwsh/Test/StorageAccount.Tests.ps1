BeforeAll {
    Import-Module -Name $PSScriptRoot/Benchpress/Helpers/Azure/StorageAcccount.psm1
    Import-Module -Name $PSScriptRoot/Benchpress/Helpers/Azure/Bicep.psm1
}

Describe 'Verify Storage Account Exists' {
    it 'Should contain a storage account named mystnamebicep' {
        #arrange
        $resourceGroupName = 'rg-test-bicep'
        $storageAccountName = 'mystnamebicep'

        #act
        $exists = Get-StorageAccountExists $resourceGroupName $storageAccountName

        #assert
        $exists | Should -Be $true
    }
}

Describe 'Spin up , Tear down Storage Account' {
    it 'Should deploy a bicep file.' {

        #arrange
        $bicepPath = "./Resources/storageAccount.bicep"
        $params = @{
            name = "rg-test-bicep"
            location = "eastus"
        }
        $resourceGroupName = "rg-test-bicep"
        $storageAccountName = 'mystnamebicep'

        #act
        $deployment = Deploy-BicepFeature $bicepPath $params $resourceGroupName

        #assert
        $deployment.ProvisioningState | Should -Be "Succeeded"
    }

    it 'Should Check Storage Sku Name'{
        #arrange
        $resourceGroupName = 'rg-test-bicep'
        $storageAccountName = 'mystnamebicep'

        #act
        $getStorageAccountSku = Get-StorageAccountSku $resourceGroupName $storageAccountName

        #assert
        $getStorageAccountSku | Should -Be "Standard_GRS"
    }

    it 'Should Check Storage Kind'{
        #arrange
        $resourceGroupName = 'rg-test-bicep'
        $storageAccountName = 'mystnamebicep'

        #act
        $getStorageAccountKind = Get-StorageAccountKind $resourceGroupName $storageAccountName

        #assert
        $getStorageAccountKind | Should -Be "StorageV3"
    }

    it 'Clean Up Deployed Resources'{
        Remove-BicepFeature $resourceGroupName
    }
}
