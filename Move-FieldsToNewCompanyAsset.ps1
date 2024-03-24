# See Usage Examples at https://github.com/lwhitelock/HuduAPI#Usage

# Import HuduApi Module
Import-Module HuduApi

# Set Hudu Base URL
New-HuduBaseURL -BaseURL https://subdomain.huducloud.com/

# Set Hudu API Key
New-HuduAPIKey -ApiKey sQfYjDqQC2YTHUsopRGPwx34

# Set Company A & B Names
$CompanyNameA = "Company A"
$CompanyNameB = "Company B"

# Set Asset Variables
$AssetName = "COA-AP-01"
$AssetType = "Wireless aps"
$AssetFields = ("Site","Model","Device IP","Management IP Address/URL","Manufacturer","Serial Number","MAC Address","Description/Notes")

# Get Company A & B Id Numbers
$CompanyIdA = (Get-HuduCompanies -name $CompanyNameA).id
$CompanyIdB = (Get-HuduCompanies -name $CompanyNameB).id

# Get All Assets from Company A by Asset Type
$AssetsCompanyA = Get-HuduAssets -CompanyId $CompanyIdA | Where-Object {$_.asset_type -eq $AssetType}

# Get Asset by Asset Name
$AssetCompanyA = $AssetsCompanyA | Where-Object {$_.name -eq $AssetName}

# Get Asset Field Data
$AssetField01 = $AssetCompanyA.fields | where-object {$_.label -eq $AssetFields[0]}
$AssetField02 = $AssetCompanyA.fields | where-object {$_.label -eq $AssetFields[1]}
$AssetField03 = $AssetCompanyA.fields | where-object {$_.label -eq $AssetFields[2]}
$AssetField04 = $AssetCompanyA.fields | where-object {$_.label -eq $AssetFields[3]}
$AssetField05 = $AssetCompanyA.fields | where-object {$_.label -eq $AssetFields[4]}
$AssetField06 = $AssetCompanyA.fields | where-object {$_.label -eq $AssetFields[5]}
$AssetField07 = $AssetCompanyA.fields | where-object {$_.label -eq $AssetFields[6]}
$AssetField08 = $AssetCompanyA.fields | where-object {$_.label -eq $AssetFields[7]}

# Format Asset Field Data as Object
$Fields = @(
    @{
          "$($AssetField01.label)" = "$($AssetField01.value)"
          "$($AssetField02.label)" = "$($AssetField02.value)"
          "$($AssetField03.label)" = "$($AssetField03.value)"
          "$($AssetField04.label)" = "$($AssetField04.value)"
          "$($AssetField05.label)" = "$($AssetField05.value)"
          "$($AssetField06.label)" = "$($AssetField06.value)"
          "$($AssetField07.label)" = "$($AssetField07.value)"
          "$($AssetField08.label)" = "$($AssetField08.value)"
    }
)

# Create New Asset under Company B with Company A Asset Data
New-HuduAsset -name $AssetCompanyA.name -company_id $CompanyIdB -asset_layout_id $AssetCompanyA.asset_layout_id -fields $Fields

# Delete Company A Asset
Remove-HuduAsset -Id $AssetCompanyA.id -company_id $CompanyIdA -Confirm:$False
