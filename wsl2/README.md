### WSL2 and VPN problems resolution

1. Configure wsl nameservers for correct resolution
    - luanch wsl distro and disable auto `/etc/resolve.conf` generation in `/etc/wsl.conf`

    `wsl.conf`
    ```
    [network]
    generateResolvConf = false
    ```
    - put VPN virtual adapters addresses in `resolve.conf`
    
    ```
    Get-NetAdapter
    Get-DnsClientServerAddress -InterfaceAlias "{adapter name}"
    ```
    `resolve.conf`
    ```
    nameserver {address 1}
    nameserver 8.8.8.8
    nameserver {address 2}
    nameserver 8.8.4.4
    ```

    - restart distro

2. Fix mtu mismatch
    - check virtual adapter mtu size
    
    ```
    Get-NetIPInterface "{adapter name}"
    ```

    - set the same mtu size for wsl distro adapter

    `wsl.conf`
    ```
    [boot]
    command = /sbin/ifconfig eth0 mtu 1350
    ```

    PS: if vpn dies you prolly have to set mtu again

    ```
    sudo ifconfig eth0 mtu 1350 up
    ```
