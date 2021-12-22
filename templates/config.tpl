Host ${hostname}
    HostName ${hostname}
    User root
    PreferredAuthentications publickey
    IdentityFile /vagrant/${cert_name}