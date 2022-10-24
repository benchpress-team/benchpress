$ROOT_PATH = $PSScriptRoot | split-path -parent | split-path -parent | split-path -parent | split-path -parent | split-path -parent

BeforeAll {
  Import-Module -Name $ROOT_PATH/Benchpress/Helpers/Azure/ResourceGroup.psm1
  Import-Module -Name $ROOT_PATH/Benchpress/Helpers/Azure/Bicep.psm1
}

Describe 'Verify Resource Group Exists' {
  it 'Should contain a resource group named tflintrules' {
    #arrange
    $rgName = "rg-test-bicep"

    #act
    $exists = Get-ResourceGroupExists($rgName)

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Spin up , Tear down Resource Group' {
  it 'Should deploy a bicep file.' {
    #arrange
    $bicepPath = "$ROOT_PATH/samples/dotnet/samples/pwsh/resourceGroup.bicep"
    $params = @{
      name        = "rgtestocw11"
      location    = "westus"
      environment = "ocwtest"
    }
    #act
    $deployment = Deploy-BicepFeature $bicepPath $params
    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    Remove-BicepFeature $params
  }
}
