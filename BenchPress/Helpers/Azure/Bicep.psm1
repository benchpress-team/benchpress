# Bicep Feature receives three parameters.
# 1. Bicep file path. 2. parameters 3. resourceGroupName

function Deploy-BicepFeature([string]$path, $params, $resourceGroupName){
  # armPath will be assigned for same bicep file name with json extension
  $fileName = [System.IO.Path]::GetFileNameWithoutExtension($path)
  $folder = Split-Path $path
  $armPath  = Join-Path -Path $folder -ChildPath "$fileName.json"

  # az bicep build will create arm template from bicep file.
  # Arm template will same as bicep name with json extension
  Write-Host "Transpiling Bicep to Arm"
  az bicep build --file $path

  $code = $?
  if ($code -eq "True") {
    $location = $params.location
    $deploymentName = $params.name

    # if user did not pass third parameter to this function. It will deploy using New-AzSubscriptionDeployment
    if ([string]::IsNullOrEmpty($resourceGroupName)) {
      Write-Host "Deploying ARM Template ($deploymentName) to $location"
      New-AzSubscriptionDeployment -Name "$deploymentName" -Location "$location" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
    elseif(-not (Get-AzResourceGroup -Name $resourceGroupName)){
      #if resourceGroupName does not exist it will deploy using New-AzSubscriptionDeployment
      Write-Host "Creating New Resource Group ($resourceGroupName) and Deploying ARM Template ($resourceGroupName) to $location"
      New-AzSubscriptionDeployment -Name "$resourceGroupName" -Location "$location" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
    else{
      #if resourceGroupName exist it will deploy using New-AzResourceGroupDeployment
      Write-Host "Deploying ARM Template ($resourceGroupName) to $location"
      New-AzResourceGroupDeployment -ResourceGroupName "$resourceGroupName" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
  }

  Write-Host "Removing Arm template json"
  rm "$armPath"
}

function Remove-BicepFeature($resourceGroupName){
  Get-AzResourceGroup -Name $resourceGroupName | Remove-AzResourceGroup -Force
}

Export-ModuleMember -Function Deploy-BicepFeature, Remove-BicepFeature
