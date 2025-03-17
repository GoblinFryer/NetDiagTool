# **Network Diagnostic Tool**

Network Diagnostic tool is a simple interface that as the vocation to display generic network informations - Network Diagnostic Tool also works on remote machine as long as they are reachable through your network.

![image]()

## Status

Still a work in progress

## Features/To Do

-  Services status (DNS/DHCP) ✅ 
-  Latency ✅ 
-  Physical network interface informations ✅ 
-  TraceRT ✅
-  NSLookUp ✅
-  Improving ergonomy 

##  **1. How To Launch** 

To use Network Diagnostic Tool right click on it and launch it as administrator - some commands require admin rights. 

## **2. How To Use** 

First make sure that WinRM protocol is authorized on your network.  

## **3. What/How To Edit**

You have the possibility to modify what the script can display pretty easily. Here's what you can modify: [^3]

- User's AD informations
- Search suggestions

#### 1. **User AD informations**

To modify this parameter just look for the following line (in the *$infos.add_click block*):

 ` $properties = "displayed","properties" and $PCproperties = "displayed","properties" `

Here, specify what parameters you want to see - you can use the following command in PowerShell to look at all available parameters ` 'Get-ADUser -Identity "username" -Properties * ` .

Then, just assigned those parameters to *$properties*.

` example: $properties = "AccountExpirationDate","created" `

#### 2. **Search Suggestions**

Just look for the following lines (in #TEXTBOX1 and #TEXTBOX2):

` $ou ='OU=,OU=,DC=,DC=,DC=' `

You just need to specify Domain Controller (DC) and Organizational Unit (OU).

` example: $ou = 'OU=computers,OU=city,DC=my','DC=domain' `

[^1]: It tries to
[^2]: the application might not work properly on your environment do not hesitate to modify the source code
[^3]: You can modify all the script but those are the most easily configurable parameters
