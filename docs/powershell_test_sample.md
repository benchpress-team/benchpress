# How to test PowerShell Test Sample Code

Following instruction shows how to run StorageAccount.Tests.ps1 file

File is located under following directory: `/samples/dotnet/samples/pwsh/Test`

Before running the test file, create resource group manually with resourceGroupName name and location
`New-AzResourceGroup -Name "rg-test-bicep" -Location "eastus"`

Run the test `.\StorageAccount.Tests.ps1`

`StorageAccount.Tests.ps1` - Content.

```powershell
#repo root path
$ROOT_PATH = $PSScriptRoot | split-path -parent | split-path -parent | split-path -parent | split-path -parent | split-path -parent

BeforeAll {
    Import-Module -Name $ROOT_PATH/Benchpress/Helpers/Azure/StorageAcccount.psm1
    Import-Module -Name $ROOT_PATH/Benchpress/Helpers/Azure/Bicep.psm1
}

#global varaibles with required values for the tests
$script:storageAccountName = 'mystnamebicepv2'
$script:resourceGroupName = 'rg-test-bicep'

Describe 'Spin up , Tear down Storage Account' {
    it 'Should deploy a bicep file.' {

      #bicep file path
      $bicepPath = "$ROOT_PATH/samples/dotnet/samples/pwsh/storageAccount.bicep"

      #required parameters for storage account deployment
      $params = @{
        name = "mystnamebicepv2"
        location = "eastus"
      }

      #calling Deploy-BicepFeature helper to deploy resources. $resourceGroupName is mandatory
      $deployment = Deploy-BicepFeature $bicepPath $params $resourceGroupName

      #checking the return state from deployment
      $deployment.ProvisioningState | Should -Be 'Succeeded'
    }

    it 'Should check storage account exist' {
      #Calling StorageAccount helper method to check expected storage account exist
      $storageAccount = Get-StorageAccountExists $resourceGroupName $storageAccountName

      #assert return value from StorageAccount helper
      $storageAccount | Should -Not -BeNullOrEmpty -ErrorAction Stop
    }

    it 'Should Check Storage Sku Name'{

      #Calling StorageAccount helper method to check for expected storage Sku
      $getStorageAccountSku = Get-StorageAccountSku $resourceGroupName $storageAccountName

      #assert return value from StorageAccount helper
      $getStorageAccountSku | Should -Be "Standard_LRS"
    }

    it 'Should Check Storage Kind'{
      #Calling StorageAccount helper method to check for expected storage Kind
      $getStorageAccountKind = Get-StorageAccountKind $resourceGroupName $storageAccountName

      #assert return value from StorageAccount helper
      $getStorageAccountKind | Should -Be "StorageV2"
    }

    it 'Delete Deployed Resources'{
      #Call Bicep helper to remove deployed resources
      Remove-BicepFeature $resourceGroupName
    }
}

```