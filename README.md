## NOTE: This content is no longer being maintained or supported.
Please see updated blueprints here: [https://docs.microsoft.com/en-us/azure/governance/blueprints/samples/](https://docs.microsoft.com/en-us/azure/governance/blueprints/samples/)

# Solution Overview

For more information about this solution, see [Azure Security and Compliance Blueprint - UK-OFFICAL Three-Tier Web Applications Automation](https://aka.ms/ukwebappblueprint).

# Deploy the Solution

These templates automatically deploy the Azure resources for a Windows based three-tier application with an Active Directory Domain architecture. **As this is a complex deployment that delivers the full infrastructure and environment, it can take up to two hours to deploy using the Azure Portal (Method 2).** Progress can be monitored from the Resource Group blade and Deployment output blade in the Azure Portal.

Rather than developing the templates for this environment from scratch, some templates used are drawn from the [Microsoft Patterns and Practices GitHub Repository](https://github.com/mspnp) as well as [Template Building Blocks](https://github.com/mspnp/template-building-blocks). There are two methods that can be used to deploy this reference architecture. The first method uses a [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/overview?view=azurermps-6.10.0) script, whereas the second method utilises the Azure Portal. Both methods are detailed in the sections below.

 ### Pre-requisites

 In order to use these templates, users should ensure that they have:

- A valid Azure Subscription
- Admin or co-admin rights for the Azure Subscription
- The Azure Subscription ID ([Find your Azure Subscription ID in the Azure Portal](https://blogs.msdn.microsoft.com/mschray/2016/03/18/getting-your-azure-subscription-guid-new-portal/))
- The [latest version of PowerShell](https://azure.microsoft.com/documentation/articles/powershell-install-configure/) and the [Azure Resource Manager module](https://docs.microsoft.com/powershell/azure/install-azurerm-ps?view=azurermps-4.4.1) for PowerShell to execute the deployment script

### Additional Resources

Many supporting resources exist that will assist in the creation of a suitable architecture for your workload, these include:
- Azure architectural best practices guidance in the [Azure Reference Architectures](https://docs.microsoft.com/azure/guidance/guidance-architecture)
- A library of Azure Resource Manager architecture templates can be found at [Azure Reference Architectures ARM Templates](https://github.com/mspnp/reference-architectures) - including a set of supporting Microsoft Visio diagrams which is available from the [Microsoft download center](http://download.microsoft.com/download/1/5/6/1569703C-0A82-4A9C-8334-F13D0DF2F472/RAs.vsdx)
- Community contributed templates are available in [Azure Quickstart](https://azure.microsoft.com/en-us/resources/templates/)

## Method 1: PowerShell Deployment Process

To deploy this solution through Azure PowerShell, you will need the latest version of the Azure Resource Manager module to run the PowerShell script that deploys the solution. To deploy the reference architecture, follow these steps:
1. Download or clone the solution folder from [GitHub](https://github.com/Azure/uk-official-three-tier-webapp) to your local machine.
2. Open a PowerShell Window and navigate to the `\compliance\uk-official\three-tier-web-with-adds\` folder.
3. Run the following command:  `.\Deploy-ReferenceArchitecture.ps1 <subscription id> <location> <mode>`
4. Replace `<subscription id>` with your Azure subscription ID.
5. For `<location>`, specify an [Azure region](https://azure.microsoft.com/en-us/global-infrastructure/regions/), such as `UKSouth` or `UKWest`.
6. The <mode> parameter controls the granularity of the deployment. The default value is `DeployAll` if no <mode> is selected. The <mode> can be one of the following values:
- `Infrastructure`: deploys only the networking infrastructure including virtual networks, subnets, network security group and vpn gateway resources
- `ADDS`: deploys the VMs acting as Active Directory Domains Services servers, deploys Active Directory to these VMs, and deploys the domain in Azure.
- `Operational`: deploys the web, business and data tier VMs and load balancers
- `DeployAll`: deploys all the preceding deployments.

> The parameter files include hard-coded passwords in various places. It is strongly recommended that you change these values.
> If the parameters files are not updated, the default values will be used which may not be compatible with your on-premises environment. For production scenarios it is recommended to investigate using [Azure Key Vault](https://azure.microsoft.com/en-us/services/key-vault/) to store secure values and only pass these during the deployment process, for more information see [Use Azure Key Vault to pass secure parameter value during deployment](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-keyvault-parameter).

## Method 2: Azure Portal Deployment Process

A deployment for this reference architecture is available on
[GitHub](https://github.com/Azure/uk-official-three-tier-webapp). The templates can be cloned or downloaded if customisation of parameters is required.
The reference architecture is deployed in three stages: `Networking -> Active Directory -> Workload`. To deploy the architecture, follow the steps below for each deployment stage.

> For virtual machines, the parameter files include hard-coded administrator user names and passwords. These values can be changed in the parameter files if required. It is ***strongly recommended that you immediately change both on all the VMs***. Click on each VM in the Azure portal then click on **Reset password** in the **Support troubleshooting** blade.

### Stage 1: Deploy Networking Infrastructure

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fuk-official-three-tier-webapp%2Fmaster%2Ftemplates%2Fvirtualnetwork.azuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>

1. Click on the **Deploy to Azure** button to begin the first stage of the deployment. The link takes you to the [Azure Portal](https://portal.azure.com).
2. In the Basic section, in the **Resource group** textbox, select **Create New** and enter a value such as `uk-official-networking-rg`.
3. Select a region such as `UKSouth` or `UKWest`, from the **Location** drop down box. All Resource Groups required for this architecture should be in the same Azure region (e.g., `UKSouth` or `UKWest`).
4. Some parameters can be edited in the deployment page. For full compatibility with your on-premises environment, review the network parameters and customise your deployment, if necessary. If greater customisation is required, this can be done through cloning and editing the templates directly, or in situ by editing the templates by clicking **Edit template** (in the Template section at the top of the page).
5. Review the terms and conditions, then click the **I agree to the terms and conditions stated above** checkbox.
6. Click on the **Purchase** button.
7. Check the Azure Portal notifications for a message stating that this stage of deployment is complete and proceed to the next deployment stage.

![alt text](images/create-official-networking-rg.JPG?raw=true "Create ADDS deployment")

>If for some reason your deployment fails, it is advisable to delete the resource group in its entirety to avoid incurring cost and orphan resources, fix the issue, and redeploy the resource groups and template.

### Stage 2: Deploy Active Directory Domain

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fuk-official-three-tier-webapp%2Fmaster%2Ftemplates%2Faads.azuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>

1. Click on the **Deploy to Azure** button to begin the second stage of the deployment. The link takes you to the [Azure Portal](https://portal.azure.com).
2. In the Basic section, in the **Resource group** textbox, select **Create New** and enter a value such as `uk-official-adds-rg`.
3. Select a region such as `UKSouth` or `UKWest`, from the **Location** drop down box. All Resource Groups required for this architecture should be in the same Azure region (e.g., `UKSouth` or `UKWest`).
4. Some domain parameters will need to be edited in the deployment page, otherwise default example values will be used. For full compatibility with your on-premises environment, review the domain parameters and customise your deployment, if necessary. If greater customisation is required, this can be done through cloning and editing the templates directly, or in situ by editing the templates by clicking **Edit template** or **Edit parameters** (in the Template section at the top of the page).
5. In the **Settings** textboxes, enter the networking resource group as entered when creating the networking infrastructure in deployment step 1 (e.g. `uk-official-networking-rg`).
6. Enter the Domain settings and Admin credentials.
7. Review the terms and conditions, then click the **I agree to the terms and conditions stated above** checkbox.
8. Click on the **Purchase** button.
9. Check Azure Portal notifications for a message stating that this stage of deployment is complete and proceed to the next deployment stage if completed.

![alt text](images/create-official-aads-rg.JPG?raw=true "Create ADDS deployment")

>If for some reason your deployment fails, it is advisable to delete the resource group in its entirety to avoid incurring cost and orphan resources, fix the issue, and redeploy the resource groups and template.

> **Note**: The deployment includes default passwords if left unchanged. It is strongly recommended that you change these values.

### Stage 3: Deploy Operational Workload Infrastructure

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fuk-official-three-tier-webapp%2Fmaster%2Ftemplates%2Fworkloads.azuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>

1. Click on the **Deploy to Azure** button to begin the third stage of the deployment. The link takes you to the [Azure Portal](https://portal.azure.com).
2. In the Basic section, in the **Resource group** textbox, select **Create New** and enter a value such as `uk-official-operational-rg`.
3. Select a region, such as UKSouth or UKWest, from the Location drop down box. All Resource Groups required for this architecture should be in the same Azure region (e.g., `UKSouth` or `UKWest`).
4. Some parameters can be edited in the deployment page. If greater customisation is required, this can be done through cloning and editing the templates directly, or in situ by editing the templates by clicking **Edit template** or **Edit parameters** (in the Template section at the top of the page).
5. In the **Settings** textboxes, enter the operational network resource group as entered when creating the networking infrastructure in deployment step 1 (e.g. `uk-official-networking-rg`).
6. Enter the Virtual Machine Admin credentials.
7. Review the terms and conditions, then click the **I agree to the terms and conditions stated above** checkbox.
8. Click on the **Purchase** button.
9. Check Azure Portal notifications for a message stating that this stage of deployment is complete.

![alt text](images/create-official-workload-rg.JPG?raw=true "Create ADDS deployment")

> If for some reason your deployment fails, it is advisable to delete the resource group in its entirety to avoid incurring cost and orphan resources, fix the issue, and redeploy the resource groups and template.

> **Note**: The deployment includes default passwords if left unchanged. It is strongly recommended that you change these values.

## Deployment and Configuration Activities

The table below provides additional information about deployment parameters, as well as other configuration steps related to the deployment activities.

  Activity|Configuration|
  ---|---
  Create Management VNet Resource Groups|Enter resource group name during deployment .
  Create Operational VNet Resource Groups|Enter resource group name during deployment.
  Deploy  VNet network infrastructure|Enter resource group name during deployment.
  Create VNet Peerings|None required.|
  Deploy VPN Gateway|The template deploys an Azure environment with a public facing endpoint and an Azure Gateway to allow site-to-site VPN setup between the Azure environment and your on-premises environment. To complete this VPN connection, you will need to provide the Local Gateway (your on-premises VPN public IP address) and complete the VPN connection set up locally. VPN Gateway requires local gateway configuration in the [/parameters/azure/ops-network.parameters.json](/parameters/azure/ops-network.parameters.json) template parameters file or through the Azure Portal.
  Deploying internet facing Application Gateway|For SSL termination, Application Gateway requires you SSL certificates to be uploaded. When provisioned, the Application Gateway will instantiate a public IP address and domain name to allow access to the web application.
  Create Network Security Groups for VNETs|RDP access to the management VNet Jumpbox must be secured to a trusted IP address range. It is important to amend the "sourceAddressPrefix" parameter with your own trusted source IP address range in the [/parameters/azure/nsg-rules.parameters.json](/parameters/azure/nsg-rules.parameters.json) template parameters file. NSG configuration for the operational VNet can be found at [/parameters/azure/ops-vent-nsgs.json](/parameters/azure/ops-vent-nsgs.json).
  Create ADDS resource group|Enter resource group name during deployment and edit the configuration fields if required.
  Deploying ADDS servers|None required.
  Updating DNS servers|None required.
  Create ADDS domain|The provided templates create a demo 'treyresearch' domain. To ensure that the required Active Directory Domain is created with the desired domain name and administrative user the fields can be configured in the deployment screen or the [/parameters/azure/add-adds-domain-controller.parameters.json](/parameters/azure/add-adds-domain-controller.parameters.json) template parameters file must be edited with the required values.
  Create ADDS domain controller|None required.
  Create operational workload Resource Group|Enter resource group name during deployment.
  Deploy operational VM tiers and load balancers   |None required.
  Set up IIS web server role for web tier|None required.
  Enable Windows Auth for VMs|None required.
  Deploy Microsoft Anti-malware to VMs|None required.
  Domain Join VMs|Domain joining the Virtual Machines is a post deployment step and must be **manually** completed.

# UK Government Private Network Connectivity

Microsoft's customers are now able to use [private connections](https://news.microsoft.com/2016/12/14/microsoft-now-offers-private-internet-connections-to-its-uk-data-centres/#sm.0001dca7sq10r1couwf4vvy9a85zx)
to the Microsoft UK datacentres (UK West and UK South). Microsoft's partners benefit by providing a gateway from PSN/N3 to [ExpressRoute](https://azure.microsoft.com/services/expressroute/) and into Azure, and this is just one of the new services the group has unveiled since Microsoft launched its [Azure](https://azure.microsoft.com/blog/) and Office 365 cloud offering in the UK. (https://news.microsoft.com/en-gb/2016/09/07/not-publish-microsoft-becomes-first-company-open-data-centres-uk/). Since then, [**thousands of customers**](https://cloudblogs.microsoft.com/industry-blog/en-gb/industry/financial-services/microsoft-uk-data-centres-continue-to-build-momentum/), including the Ministry of Defence, the Met Police, and parts of the NHS, have signed up to take advantage of the sites. These UK datacentres offer UK data residency, security and reliability.

# Cost

Deploying this template will create one or more Azure resources. You will be responsible for the costs generated by these resources, so it is important that you review the applicable pricing and legal terms associated with all resources and offerings deployed as part of this template. For cost estimates, you can use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator).

# Further Reading

Further best practice information and recommendations for configuring and securing a multi-tier application in Azure can be found in [Running Windows VMs for an N-tier architecture on Azure](https://docs.microsoft.com/azure/guidance/guidance-compute-n-tier-vm).

Best practices on Azure Network Security and a decision-making matrix can be found in [Microsoft cloud services and network security](https://docs.microsoft.com/azure/best-practices-network-security).

Additional security, compliance and governance information as well as specific guidance on regularity compliance control that can be added to your architecture can be found in the [Azure Security Documentation](https://docs.microsoft.com/en-us/azure/security/) library, under the `Governance and Compliance` section. This includes specific guidance on topics such as `PCI DSS`, `GDPR`, `UKS NHS` and `NIST SP 800-171`.

# Disclaimer

- This document is for informational purposes only. MICROSOFT MAKES NO WARRANTIES, EXPRESS, IMPLIED, OR STATUTORY, AS TO THE INFORMATION IN THIS DOCUMENT. This document is provided "as-is." Information and views expressed in this document, including URL and other Internet website references, may change without notice. Customers reading this document bear the risk of using it.  
- This document does not provide customers with any legal rights to any intellectual property in any Microsoft product or solutions.  
- Customers may copy and use this document for internal reference purposes.  
- Certain recommendations in this document may result in increased data, network, or compute resource usage in Azure, and may increase a customer's Azure license or subscription costs.  
- This architecture is intended to serve as a foundation for customers to adjust to their specific requirements and should not be used as-is in a production environment.
- This document is developed as a reference and should not be used to define all means by which a customer can meet specific compliance requirements and regulations. Customers should seek legal support from their organization on approved customer implementations.

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

