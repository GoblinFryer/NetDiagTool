# **Network Diagnostic**

Network Diagnostic tool is a simple interface that as the vocation to display generic network informations - Network Diag also works on remote machine as long as they are reachable through the network.

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

To install AD-Displayer just double click on the .exe file. As simple as that.

## **2. How To Use** 

Each button have a specific interaction with the textboxe. Let see how each button work. 👇 

#### 1. **INFOS Button** 

- The first textbox is used for user ID, as follow: **Alias** or **Firstname Lastname** (order is important)
- The second text is used for PC ID, as follow: **AD computer's name**

Then click on INFOS button and the result should be displayed in the third textbox (the big one).

#### 2. **AD Groups Button**

Here, only the first textbox is used. Simply type the computer name or user ID (*alias* or *firstname lastname*) and then press AD groups.

#### 3. **Compare Button**

For this one, the two textboxes are used and it will compare the first entry (typed into 1.) to the second entry (typed into 2.) and then it will compare AD groups that the first entry have that the second one do not have (order is important here) and will display the result.

That's it ! Pretty simple. 😉 

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
