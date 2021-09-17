# Switch DNS
Switch Network Adaptor DNS by One-Click.

## Who Needs It
If you always need to set/reset DNS to your network adaptor between home and the office, this tool will save your life.  

## How To Use
You will need 2 `bat` files: One to Enable DNS and the other to Disable DNS (Reset).  
1. Download `set-dns.bat` and rename to `home.bat` and `office.bat`.  
2. In `home.bat`, keep:
```
netsh interface ipv4 set dns name="以太网" source=static addr=8.8.8.8 register=PRIMARY
```
In `office.bat`, keep:
```
netsh interface ipv4 set dns name="以太网" source=dhcp
```
Here assume your network adaptor name is '以太网'. You can change on demand. 
