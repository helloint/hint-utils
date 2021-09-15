# Switch DNS
You might always need to CMD file: One to Enable DNS and another to Disable DNS (Reset).  
For example, if you need to enable DNS at home and disable DNS in the office,
just rename `set-dns.bat` to `home.bat` and `office.bat`, then in `home.bat`, keep:
```
netsh interface ipv4 set dns name="以太网" source=static addr=8.8.8.8 register=PRIMARY
```
In `office.bat`, keep:
```
netsh interface ipv4 set dns name="以太网" source=dhcp
```
Here assume your network adaptor name is '以太网'. You can change on demand. 
