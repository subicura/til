# SSH Proxy

```
ssh -o ProxyCommand='ssh user@bastion -W %h:%p -i ~/.ssh/private.pem -p 2222' user@target -i ~/.ssh/private.pem
```
