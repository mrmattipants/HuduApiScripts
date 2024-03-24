# See Usage Examples at https://github.com/lwhitelock/HuduAPI#Usage

# Import HuduApi Module
Import-Module HuduApi

# Set Hudu Base URL
New-HuduBaseURL -BaseURL https://subdomain.huducloud.com/

# Set Hudu API Key
New-HuduAPIKey -ApiKey sQfYjDqQC2YTHUsopRGPwx34

# Set Asset Variables
$AssetNameA = "COA-AP-01"
$AssetNameB = "COB-AP-01"
$AssetType = "Wireless aps"
$AssetFields = ("Site","Model","Device IP","Management IP Address/URL","Manufacturer","Serial Number","MAC Address","Description/Notes")

# Set Company A & B Names
$CompanyNameA = "Company A"
$CompanyNameB = "Company B"

# Get Company A & B Id Numbers
$CompanyIdA = (Get-HuduCompanies -name $CompanyNameA).id
$CompanyIdB = (Get-HuduCompanies -name $CompanyNameB).id

# Get All Assets from Company A & B by Asset Type
$AssetsCompanyA = Get-HuduAssets -CompanyId $CompanyIdA | Where-Object {$_.asset_type -eq $AssetType}
$AssetsCompanyB = Get-HuduAssets -CompanyId $CompanyIdB | Where-Object {$_.asset_type -eq $AssetType}

# Get Company A & B Assets by Asset Name
$AssetCompanyA = $AssetsCompanyA | Where-Object {$_.name -eq $AssetNameA}
$AssetCompanyB = $AssetsCompanyB | Where-Object {$_.name -eq $AssetNameB}

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

# Update Existing Company B Asset with Company A Asset Data
Set-HuduAsset -name $AssetCompanyB.name -company_id $CompanyIdB -asset_layout_id $AssetCompanyB.asset_layout_id -fields $Fields -asset_id $AssetCompanyB.id
