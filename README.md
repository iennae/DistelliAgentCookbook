DistelliAgentCookbook
=====================

This chef cookbook installs the Distelli Agent on a server. 

Usage
-----

Include `distelli_agent` in your `run_list` and set your attributes with your Distelli Access Token and Distelli Secret key found in your Distelli Account.

Additionally you can specify an S3 Bucket and S3 access credentials if you wish to store deployable bundles in Amazon S3.

```json
{
  "name": "my_node",
  "run_list": [
    "recipe[distelli_agent]"
  ],
  "default": {
    "distelli": {
        "agent": {
          "access_token": "DISTELLI_ACCESS_TOKEN",
          "secret_key": "DISTELLI_SECRET_KEY",
          "s3_bucket_name": "S3_BUCKET_NAME",
          "s3_access_key_id": "S3_ACCESS_KEY_ID",
          "s3_secret_key": "S3_SECRET_KEY"
        }
      },
  }
}
```

