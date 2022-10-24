function Deploy-BicepFeature([string]$path, $params, $resourceGroupName){
  $fileName = [System.IO.Path]::GetFileNameWithoutExtension($path)
  $folder = Split-Path $path
  $armPath  = Join-Path -Path $folder -ChildPath "$fileName.json"

  Write-Host "Transpiling Bicep to Arm"
  az bicep build --file $path

  $code = $?
  if ($code -eq "True") {
    $location = $params.location
    $deploymentName = $params.name

    Write-Host "Deploying ARM Template ($deploymentName) to $location"

    if ([string]::IsNullOrEmpty($resourceGroupName)) {
      New-AzSubscriptionDeployment -Name "$deploymentName" -Location "$location" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
    else{
      if (-not (Get-AzResourceGroup -Name $resourceGroupName)) {
        Write-Host "Creating Resource Group ($resourceGroupName) in $location"

        New-AzResourceGroup -Name $resourceGroupName -Location $location
      }
      Write-Host "Deploying ARM Template ($deploymentName) to $location"

      New-AzResourceGroupDeployment -ResourceGroupName "$resourceGroupName" -TemplateFile "$armPath"
    }
  }

  Write-Host "Removing Arm template json"
  rm "$armPath"
}

function Remove-BicepFeature($resourceGroupName){
  Get-AzResourceGroup -Name $resourceGroupName | Remove-AzResourceGroup -Force
}

Export-ModuleMember -Function Deploy-BicepFeature, Remove-BicepFeature
