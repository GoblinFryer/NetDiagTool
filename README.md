# **Network Diagnostic Tool**

Network Diagnostic Tool is a simple interface that as the vocation to display generic network informations - Network Diagnostic Tool also works on remote machine as long as they are reachable through your network.

![image](https://github.com/user-attachments/assets/7bb3251b-138f-4400-8b7c-f70e6e98f530)

## Status

Done ✅

## Features/To Do

-  Services status (DNS/DHCP) ✅ 
-  Latency ✅ 
-  Physical network interface informations ✅ 
-  TraceRT ✅
-  NSLookUp ✅
-  Improving ergonomy/UI ✅

##  **1. How To Launch** 

To use Network Diagnostic Tool right click on it and launch it as **administrator** - some commands require admin rights. 

## **2. How To Use**

First make sure that **WinRM protocol is authorized** on your network. Secondly, download the NetDiagTool.exe (here). Then, right-click on it, launch it with **administrator rights**. Once the window's open enter the nodename you want the diagnostic to run on in the textbox and press "start" - It might take some time to display the results depending on your network capabilities.

/!\ Make sure to read section 3

## **3. What/How To Edit**

For the script to run properly you have some modifications to do. Open the .ps1 file and search the following words : **"YouOwnInternalServerToTest"** and **"YourDomain"** and replace them by your needed equivalent - the executable is not formated wich will make some informations not to be displayed. [^1]

[^1]: I'm working on a way to retrieve informations needed for the .exe to be directly usable

