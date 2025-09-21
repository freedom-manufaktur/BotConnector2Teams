BotConnector2Teams - Bot Installation and Registration Manual
---
Version: `1.14.0` - `2025-06-04` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](https://github.com/freedom-manufaktur/BotConnector2Teams/tree/main/Documentation/Bot%20Installation%20and%20Registration%20Manual.md)

Table of contents
---
<!--TOC-->
- [1. Bot Service Installation](#1-bot-service-installation)
  - [Installation as Windows Service](#installation-as-windows-service)
  - [Installation as Docker Container via Docker Compose](#installation-as-docker-container-via-docker-compose)
  - [Installation as Kubernetes Deployment via HELM Chart](#installation-as-kubernetes-deployment-via-helm-chart)
- [2. Install the Teams Developer Portal](#2-install-the-teams-developer-portal)
- [3. Register a Teams bot](#3-register-a-teams-bot)
- [4. Configure the USU Knowledge Bot](#4-configure-the-usu-knowledge-bot)
- [5. Configure the microservice](#5-configure-the-microservice)
- [6. Create a personalized Teams App using your bot](#6-create-a-personalized-teams-app-using-your-bot)
- [7. Publish your Teams App to your Organization/Users](#7-publish-your-teams-app-to-your-organizationusers)
- [8. Use the Teams App](#8-use-the-teams-app)
- [What's new?](#whats-new)
  - [\[1.14.0\] - 2024-08-27](#1140---2024-08-27)
    - [Changed](#changed)
  - [\[1.12.0\] - 2024-02-27](#1120---2024-02-27)
    - [Changed](#changed-1)
    - [Fixed](#fixed)
  - [\[1.10.0\] - 2024-01-18](#1100---2024-01-18)
    - [Changed](#changed-2)
  - [\[1.9.0\] - 2023-12-20](#190---2023-12-20)
    - [Changed](#changed-3)
- [Need support?](#need-support)
<!--/TOC-->

# 1. Bot Service Installation
There are different kinds of installation. You may choose the one best suiting your needs.
* Windows Service \
   ✔ lightweight \
   ✔ easy to install, update and configure \
   ⚠ Windows only \
   ℹ .NET required (installed automatically)
* Docker Container via Docker Compose \
   ✔ containerized \
   ✔ cross platform \
   ⚠ Docker with [Docker Compose v2](https://docs.docker.com/compose/) required
* Kubernetes Deployment via [HELM Chart](https://helm.sh/) \
   ✔ containerized \
   ✔ scalable \
   ✔ cross platform \
   ⚠ Kubernetes installation required \
   ⚠ [HELM](https://helm.sh/docs/intro/install/) installation required \
   ⚠ Experience with Kubernetes and HELM Charts required

## Installation as Windows Service

**Installation**

1.  Download Installation from [BotConnector2Teams Download](https://freedommanufaktur.sharepoint.com/:f:/g/EiwKhRezGW1MmdO8NRaPJ4QBz4rFJjDtsCe8CdxmaQ9ing?e=gcJz3c)
1.  *(Optional, when offline*) Download and install the most recent [.NET 8.0 Runtimes](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
    1. ASP.NET Core Runtime x64 Installer
    2. .NET Runtime x64 Installer
1.	Install `BotConnector2Teams Setup 1.13.0`
    > Note: This will automatically install .NET 8.0 if necessary
1.  (Optional, verify running) Open a browser and navigate to \
    http://localhost:8100 \
    You should be greeted with the message\
    `Welcome to the BotConnector2Teams Microservice`
1.	Allow inbound traffic to the service.
    > The default port used is `8100`. You may change the port number at any time.
    * Use a Reverse Proxy, like IIS [Application Request Routing](https://www.iis.net/downloads/microsoft/application-request-routing) to redirect traffic to port `8100`.
        > This is the **recommended** option, as you can perform TLS/SSL termination before hitting the service and running the service in combination with other apps.

    *OR*

    * Configure your Windows Firewall to allow inbound traffic to port `8100`
        > Note: You must bind a certificate to this port and use TLS/SSL (see *Configuration*).

1.  As a result of the previous steps you should have a publically accessible and TLS secured endpoint like **https://knowledge.MyCompany.com/BC2T**. \
    We will use this address in the next steps.

**Upgrade an existing Installation**

1.	(Optional, when Offline) Download and install the most recent [.NET 8.0 Runtimes](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
    1.  ASP.NET Core Runtime x64 Installer
    1.	.NET Runtime x64 Installer
1.	Install `BotConnector2Teams Setup vNext.exe` \
    This will upgrade your existing installation.

**Configuration**

If port `8100` (default) is already in use or you want to set any other option, then navigate to the directory \
`%ProgramData%\freedom manufaktur\BotConnector2Teams` \
This directory contains the configuration for the app `appsettings.json` as well as some other app files.
Editing `appsettings.json` will show something like
```
{
  "$Help.Urls": "Enter the URLs you want the App to be available at. For example https://localhost:8101;http://localhost:8100",
  "Urls": "https://localhost:8443",
  "App": {
    "$Help.PublicUrl": "The URL for public internet access to this instance of the app. For example: https://ukm.infreiheit.de/BC2T",
    "PublicUrl": ""
  },
  "AzureBot": {
    "MicrosoftAppType": "MultiTenant",
    "MicrosoftAppId": "",
    "MicrosoftAppPassword": "",
    "MicrosoftAppTenantId": ""
  },
  "UsuBot": {
    "$Help.BaseUrl": "For example: https://ukm.infreiheit.de",
    "BaseUrl": "",
    "ApiKey": "",
    "ConnectorType": "default:Connector2Teams"
  },
  "UsuKnowledgeManager": {
    "$Help.BaseUrl": "For example: https://ukm.infreiheit.de",
    "BaseUrl": "",
    "$Help.DocumentUrl": "Omit, if equal to: [BaseUrl]/knowledgecenter/docShow.do;realm=defaulthost?mandatorKey=MANDATOR_USU&callFromKminer=true&entity.GUID={{DocumentGuid}}",
    "DocumentUrl": null
  },
  "Oktopus": {
    "$Help.BaseUrl": "For example: https://whoosh.oktopus",
    "BaseUrl": "",
    "ApiKey": ""
  },
  "License": {
    "Key": "eyJMaWNlbnN[...]"    
  },
  "Api": {
    "$Help.EnableDetailedErrorMessages": "Enable to include the full stack trace when an error occurs while calling the API.",
    "EnableDetailedErrorMessages": true
  }
}
```
As seen in the example, the URL has been re-configured to use https://localhost:8443 as address and detailed error messages have been enabled. \
*After changing `appsettings.json` you must restart the `BotConnector2Teams` Service.*

**Monitoring / Debugging**

The installation creates a new Windows Service that should be running for the service to be available

![Alt text](Images/Windows%20Service.png)

The installation also creates a new Windows Event Log source `BotConnector2Teams`. Please start the *Event Viewer* or any other Event Log monitoring tool to view the application logs.

![Alt text](Images/Windows%20Service%20Event%20Log.png)

---

## Installation as Docker Container via Docker Compose

> Attention: Starting with version 1.9.0 of `BotConnector2Teams` the docker images are **non-root** based.
> You **should** use `BotConnector2Teams` version 1.12.0 or later combined with `compose.yaml` version 1.12.0 or later.

**Installation and Configuration**

1. Download the **bot-connector-to-teams** Docker image from [BotConnector2Teams Download](https://freedommanufaktur.sharepoint.com/:f:/g/EiwKhRezGW1MmdO8NRaPJ4QBz4rFJjDtsCe8CdxmaQ9ing?e=gcJz3c) and register it with your image repository.

1. Download the Docker Compose YAML files from [BotConnector2Teams Docker Compose Download](https://github.com/freedom-manufaktur/BotConnector2Teams/tree/main/Docker%20Compose).

1. Adjust the `compose.env` with the required settings.
   > Note: Read the following chapters if you do not have all the required information.

1. Use the command `docker compose --env-file .\compose.env up` to deploy the app.

**Monitoring / Debugging**

> The Docker Compose file contains a [healthcheck](https://docs.docker.com/compose/compose-file/05-services/#healthcheck) definition that includes basic configuration checks.

Use your favorite Docker tools to check the status and logs of the app.
For example in Docker Desktop \
![Docker Compose Container Running](Images/Docker%20Compose%20Running.png)

---

## Installation as Kubernetes Deployment via HELM Chart

> Attention: Starting with version 1.9.0 of `BotConnector2Teams` the docker images are **non-root** based.
> You **should** use `BotConnector2Teams` version 1.9.0 or later combined with `Chart.yaml` version 1.9.0 or later.

**Installation and Configuration**

1. Download the **bot-connector-to-teams** Docker image from [BotConnector2Teams Download](https://freedommanufaktur.sharepoint.com/:f:/g/EiwKhRezGW1MmdO8NRaPJ4QBz4rFJjDtsCe8CdxmaQ9ing?e=gcJz3c) and register it with your image repository.

1. Download the HELM Chart files from [BotConnector2Teams HELM Chart Download](https://github.com/freedom-manufaktur/BotConnector2Teams/tree/main/HELM%20Chart).

1. Adjust the `values.yaml` with the required settings.
   > Note: Read the following chapters if you do not have all the required information.

1. Use the command `helm upgrade bot-connector . --install` to deploy the app.
1. Use the command `helm test bot-connector` to test the deployed app. \
   Expecting to see `Phase: Succeeded`.

**Monitoring / Debugging**

> The Kubernetes Deployment contains [readiness and liveness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) that include basic configuration checks.

Use your favorite Docker tools to check the status and logs of the app.
For example in Kubernetes Dashboard \
![Docker Kubernetes Running](Images/Kubernetes%20Running.png)

# 2. Install the Teams Developer Portal
1.  As an administrator or normal Teams user, open [Teams](https://teams.microsoft.com) or use the Teams Desktop App.
1.  Add the [**Developer Portal**](https://teams.microsoft.com/l/app/14072831-8a2a-4f76-9294-057bf0b42a68?source=app-details-dialog) app to your Teams. \
    *OR* \
    Go to **Apps**, search for **Developer Portal** and **Add** it. \
    ![Developer Portal](Images/Teams%20Developer%20Portal.png)

# 3. Register a Teams bot

1.  Open the **Developer Portal** app → **Tools** → **Bot management** and add a new bot. \
    ![New Bot](Images/Teams%20Developer%20Portal%20New%20Bot.png)
1.  Give the bot a name. For example *Knowledge2Teams*.
1.  Under **Configure** → **Endpoint address** enter the URL of **your** bot and append `/bot` \
    For example **`https://knowledge.MyCompany.com/BC2T/bot`** \
    ![Bot endpoint](Images/Teams%20Developer%20Portal%20Bot%20Endpoint.png)
1.  Under **Client secrets** create a new secret and write it down. \
    ![Bot secret](Images/Teams%20Developer%20Portal%20Bot%20Secret.png)
1.  Go back to the **Bot management** and write down the **Bot ID**. \
    ![Bot ID](Images/Teams%20Developer%20Portal%20Bot%20ID.png)

# 4. Configure the USU Knowledge Bot
1.  Open the USU Chatbot Manager App, typically at https://knowledge.MyCompany.com/kbot-manager/
1.  Select the desired bot, typically a *Lead Bot*. \
    ![Select Bot](Images/USU%20Knowledge%20Bot%20Select%20Bot.png)
1.  Navigate to **Mandatory Settings** → **Connectors** and select **Create Connector**.
1.  Give the name **Connector2Teams** with type **Default** and save.
1.  Enable the connector **Connector2Teams**. \
    ![Enabled Connector](Images/USU%20Knowledge%20Bot%20Connector.png)
1.  Navigate to **Advanced Settings** → **API Key** and write down the **Key**. \
    ![API Key](Images/USU%20Knowledge%20Bot%20API%20Key.png)

# 5. Configure the microservice
As a result of the previous chapters you should have the following information at your disposal:
* Microsoft Teams Bot ID (e.g. *6ee9a76d-8c22-493f-8e88-9b69bafa3386*)
* Microsoft Teams Bot Client Secret (e.g. *P~i8Q~~AUaTiAGJAaW6PIZKafDZpCNOWjoAGpatY*)
* USU Knowledge Manager URL (e.g. *https://knowledge.MyCompany.com*)
* USU Knowledge Bot URL (probably the same as *USU Knowledge Manager*)
* USU Knowledge Bot API Key (e.g. *d2hvb3NoIE9rdG9wdXMgaXMgdGhlIGJlc3QhISE=*)
* BotConnector2Teams Microservice URL (e.g. *https://knowledge.MyCompany.com/BC2T*)
* (Optional) BotConnector2Teams License Key (e.g. *eyJMaWNlbnN[...]*)
  > You may enter your license later, but you will receive an unlicensed message. Acquire a license by contacting support@freedom-manufaktur.com.
* (Optional) whoosh Oktopus instance with
  * whoosh Oktopus URL (e.g. *https://whoosh.oktopus/MyCompany*)
  * whoosh Oktopus API Key (e.g. *7isH1m5d-808CrcN_7DDK1FVV8y76iwa*)
  > [whoosh Oktopus](https://freedom-manufaktur.com/whoosh-oktopus) is required to use the `/Create Ticket` and `Save as PDF` features. Contact support@freedom-manufaktur.com to register an instance of [whoosh Oktopus](https://freedom-manufaktur.com/whoosh-oktopus).

Let's put all this together.

1.  Base on the type of installation you used, open your `appsettings.json`, `compose.env` or `values.yaml` file.

2.  Enter the information from above into the corresponding properties. *We use the Windows service as an example.*
    ```
    {
      "App": {
        "$Help.PublicUrl": "The URL for public internet access to this instance of the app. For example: https://ukm.infreiheit.de/BC2T",
        "PublicUrl": "https://knowledge.MyCompany.com/BC2T"
      },
      "AzureBot": {
        "MicrosoftAppType": "MultiTenant",
        "MicrosoftAppId": "6ee9a76d-8c22-493f-8e88-9b69bafa3386",
        "MicrosoftAppPassword": "P~i8Q~~AUaTiAGJAaW6PIZKafDZpCNOWjoAGpatY",
        "MicrosoftAppTenantId": ""
      },
      "UsuBot": {
        "$Help.BaseUrl": "For example: https://ukm.infreiheit.de",
        "BaseUrl": "https://knowledge.MyCompany.com",
        "ApiKey": "d2hvb3NoIE9rdG9wdXMgaXMgdGhlIGJlc3QhISE=",
        "ConnectorType": "default:Connector2Teams"
      },
      "UsuKnowledgeManager": {
        "$Help.BaseUrl": "For example: https://ukm.infreiheit.de",
        "BaseUrl": "https://knowledge.MyCompany.com",
        "$Help.DocumentUrl": "Omit, if equal to: [BaseUrl]/knowledgecenter/docShow.do;realm=defaulthost?mandatorKey=MANDATOR_USU&callFromKminer=true&entity.GUID={{DocumentGuid}}",
        "DocumentUrl": null
      },
      "Oktopus": {
        "$Help.BaseUrl": "For example: https://whoosh.oktopus",
        "BaseUrl": "https://whoosh.oktopus/MyCompany",
        "ApiKey": "7isH1m5d-808CrcN_7DDK1FVV8y76iwa"
      },
      "License": {
        "Key": "eyJMaWNlbnN[...]"    
      }
    }
    ```
    > Note: All non-relevant properties have been omitted for better readability.

3.  Restart the *BotConnector2Teams* Service/Container.

4.  (Optional) Open a browser and enter the URL of **your** bot and append `/healthcheck` \
    For example **`https://knowledge.MyCompany.com/BC2T/healthcheck`** \
    This should result in a page where everything has the status **Healthy**.
    ```
    {
      "status": "Healthy",
      "components": [
        {
          "name": "AzureBot",
          "status": "Healthy"
        },
        {
          "name": "UsuBot",
          "status": "Healthy"
        },
        {
          "name": "UsuKnowledgeManager",
          "status": "Healthy"
        },
        {
          "name": "Oktopus",
          "status": "Healthy"
        },
        {
          "name": "License",
          "status": "Healthy"
        },
        {
          "name": "PDF-Support",
          "status": "Healthy"
        }
      ]
    }
    ```
    If that is not the case, please go back to the previous steps and try again.

    > You now have a working Teams Bot that can be used in **any** Teams App.
      Read the next chapter on how to create a Teams App.

# 6. Create a personalized Teams App using your bot

1.  Open the **Developer Portal** app → **Apps** and import our app template ([Teams App Template.zip](https://github.com/freedom-manufaktur/BotConnector2Teams/tree/main/Downloads)) to get started as quickly as possible. \
    ![Import Teamplate](Images/Teams%20Developer%20Portal%20App%20Import%20Template.png)

1.  Duplicate the Template and give it a nice name like *Knowledge2Teams*. \
    ![Duplicate Template](Images/Teams%20Developer%20Portal%20App%20Duplicate%20Template.png)
    > ⚠ Attention\
    If you use a name **other than** *Knowledge2Teams* you **should also** update the translated names under **Configure** → **Languages** or you may confuse your users.

1.  You may now delete the template and only keep the app with a valid *App ID*. \
    ![Valid App ID](Images/Teams%20Developer%20Portal%20App%20Valid%20ID.png)

1.  Open the app to view its settings.

1.  (Optional) Adjust the information under **Configure** → **Basic information** to your liking.
    > This Teams App is now **your** app, you can configure and extend it in any way you like.
    
    > ⚠ Attention iOS users!\
    As of 2023-07-20 (*Microsoft Teams App* 5.13.0) there is a bug the iOS *Microsoft Teams App* that causes a weird looking empty screen when opening the app we just configured.\
    As a **workaround** you can add **any** personal tab (other than *Chat* and *About*)\
    **OR**\
    Enable **What can your bot do?** → **Upload and download files**, which adds an (unused) *Files* tab, also fixing the issue.

1.  Open **Configure** → **App features** → **Bot**. \
    Under **Identify your bot** select the bot that we previously created, replacing the template Bot ID *00000000-0000-0000-0000-000000000000*. Press **Save**. \
    ![Select Bot](Images/Teams%20Developer%20Portal%20App%20Select%20Bot.png)

1.  (Optional) If you **do not** want to use the `/Create Ticket` feature \
    Open **Configure** → **App features** → **Bot**. \
    Under **Commands** select the **/Create ticket** command and **Delete** it.
    > If you **do** want to use the `/Create Ticket` feature, you may add the command to the list. Afterwards, also update the command translation under **Configure** → **Languages**.

1. Your App is now ready!

# 7. Publish your Teams App to your Organization/Users

1.  Press **Publish** on your Teams App and select **Publish to your org**. \
    ![Publish App](Images/Teams%20Developer%20Portal%20App%20Publish.png)

1.  Your app should now be in *Submitted* state. \
    ![Submitted State](Images/Teams%20Developer%20Portal%20App%20Publish%20Submitted.png)

1.  As a Teams Administrator open the [Microsoft Teams Admin Center](https://admin.teams.microsoft.com/).

1.  Navigate to **Teams apps** → **Manage apps**. \
    In the list of *all* apps, search for your app **Knowledge2Teams**. \
    And finally open your app. \
    ![Select Teams App](Images/Teams%20Admin%20Center%20Select%20App.png)

1.  Press **Publish** to publish your app to your organization. \
    ![Publish App](Images/Teams%20Admin%20Center%20Publish%20App.png)
    
    > Note: **The publish process usually takes about 1-5 minutes** without any visual indication. \
      After successful submission, it should look like this. \
      ![Published App](Images/Teams%20Admin%20Center%20Publish%20App%20Success.png)
    
    > Note: When deploying the app via policy, or submitting an update it will take **up to 24 hours** before your users will receive the app.
    For testing, you may sign out/in of Teams to refresh your apps.

# 8. Use the Teams App
As a Teams user of your organization.

1.  In your [Teams App Store](https://teams.microsoft.com/_#/apps) search for **Knowledge2Teams** and add the app. \
    ![Install App](Images/Teams%20Install%20App.png)

2.  Start chatting. \
    ![Chat with bot](Images/Teams%20Use%20App.png)

3.  Done!
    > Congratulations on successfully installing, configuring, registering and using the **BotConnector2Teams**.

# What's new?
This section lists **important** changes to the documentation, *Teams App Template* and Docker files.
Please read this list when upgrading an existing installation.
> The full app changelog can be found in the [BotConnector2Teams Download](https://freedommanufaktur.sharepoint.com/:f:/g/EiwKhRezGW1MmdO8NRaPJ4QBz4rFJjDtsCe8CdxmaQ9ing?e=gcJz3c)

## [1.14.0] - 2024-08-27
### Changed
- *Docker Compose* has been updated for *Docker v25.0*.
- *HELM Chart* has been updated for *HELM 3.15.4* and *Kubernetes 1.30.2*.

## [1.12.0] - 2024-02-27
### Changed
- Documentation, *Docker Compose* and *HELM Chart* have been updated with `App:PublicUrl`, `Oktopus:BaseUrl` and `Oktopus:ApiKey` variables.
  These can be left blank, unless you want to use the `/Create Ticket` and `Save as PDF` features

### Fixed
- The *Docker Compose* healthcheck was fixed (regression from 1.9.0).

## [1.10.0] - 2024-01-18
### Changed
- *Teams App Template* now contains the `/Create Ticket` command.

## [1.9.0] - 2023-12-20
### Changed
- *Docker Compose* and *HELM Chart* have been updated for running as **non-root** container. This includes a port number change.

# Need support?
If you have any questions regarding the installation and configuration of the BotConnector2Teams, contact us at
* All questions regarding the *BotConnector2Teams* \
  [services@gentlehuman.de](mailto:services@gentlehuman.de) (Gentlehuman Factory)
* All questions around the *BotConnector2Teams Microservice* / *Teams App Registration* / *whoosh Oktopus* \
  [support@freedom-manufaktur.com](mailto:support@freedom-manufaktur.com) (freedom manufaktur)
* All questions regarding the *USU Knowledge Manager* itself \
  [support@usu.com](mailto:support@usu.com) (USU)
