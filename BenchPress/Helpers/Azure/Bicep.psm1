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

    #if user did not pass third parameter to this function. It will deploy using New-AzSubscriptionDeployment
    if ([string]::IsNullOrEmpty($resourceGroupName)) {
      Write-Host "Deploying ARM Template ($deploymentName) to $location using New-AzSubscriptionDeployment"
      New-AzSubscriptionDeployment -Name "$deploymentName" -Location "$location" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
    elseif(-not (Get-AzResourceGroup -Name $resourceGroupName)){
      #if user passed resourceGroupName but it does not exist. It will create new resource group and deployes using New-AzSubscriptionDeployment
      Write-Host "Creating New Resource Group ($resourceGroupName) and Deploying ARM Template ($resourceGroupName) to $location"
      $resource = Deploy-ResourceGroup $resourceGroupName $location
      Write-Host "resourece $resource.resourceGroupName"
      New-AzResourceGroupDeployment -ResourceGroupName $resource.resourceGroupName -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
    else{
      #if resourceGroupName exist it will deploy using New-AzResourceGroupDeployment
      Write-Host "Deploying ARM Template ($resourceGroupName) to $location using New-AzResourceGroup"
      New-AzResourceGroupDeployment -ResourceGroupName "$resourceGroupName" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
  }

  Write-Host "Removing Arm template json"
  rm "$armPath"
}

function Deploy-ResourceGroup([string]$resourceGroupName, [string]$location){
  $resource = New-AzResourceGroup -Name "$resourceGroupName" -Location "$location" -Wait
  return $resource
}

function Remove-BicepFeature($resourceGroupName){
  Get-AzResourceGroup -Name $resourceGroupName | Remove-AzResourceGroup -Force
}

Export-ModuleMember -Function Deploy-BicepFeature, Remove-BicepFeature
