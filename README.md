DistelliAgentCookbook
=====================

This chef cookbook installs the <a href="https://www.distelli.com" target="_blank">Distelli</a> Agent on a server. 

Usage
-----

Include `distelli` in your `run_list` and set your attributes with your Distelli Access Token and Distelli Secret key found in your Distelli Account.

```json
{
  "name": "my_node",
  "run_list": [
    "recipe[distelli]"
  ],
  "default": {
    "distelli": {
        "agent": {
          "access_token": "DISTELLI_ACCESS_TOKEN",
          "secret_key": "DISTELLI_SECRET_KEY",
        }
      },
  }
}
```

