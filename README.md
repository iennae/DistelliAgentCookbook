DistelliAgentCookbook
=====================

This chef cookbook installs the <a href="https://www.distelli.com" target="_blank">Distelli</a> Agent on a server. 

Attributes
----------

| Key                                  | Type | Description                                    | Default                                    |
| -----------------------------------: | ----:| ---------------------------------------------: | -----------------------------------------: |
| `[:distelli][:agent][:access_token]` | Str  | Access token to Distelli User Account          | ""                                         |
| `[:distelli][:agent][:secret_key]`   | Str  | Secret token to Distelli User Account          | ""                                         |
| `[:distelli][:agent][:endpoint]`     | Str  | Distelli server URL to register the agent with | nil                                        |
| `[:distelli][:agent][:download_url]` | Str  | Distelli server URL to download distelli agent | "https://www.distelli.com/download/client" |
| `[:distelli][:agent][:version]`      | Str  | Agent version                                  | ""                                         |

Usage
-----

Include `distelli` in your `run_list` and set your attributes with your Distelli Access Token and Distelli Secret key found in your Distelli Account settings page.

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
        }
    }
}
```

You may optionally specify the following other attributes:

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
                "version": "3.61",
                "environments": [
                    "red-staging",
                    "white-staging",
                    "blue-staging",
                ]
            }
        }
    }
}
```
