##### Basics 
See the blog post at [hifighetto.com](http://www.hifighetto.com/2021/01/terraform-deploy-aws-s3-bucket-standard.html) for more information 


There is also a [YouTube Video](https://www.youtube.com/watch?v=3Okw86bZeSA)

This is an example of creating a simple s3 bucket with versioning, AWS256 encryption, and file rotation. 

The example will transition the storage down to Standard Infrequent Access after 30 days. Then transfer it to Glacier after 60 days, and finally it will expire it af`                                                          ter 90 days. 

This should only be used as an example, if you want to use it for anything other than reference see below. 

If you want to run the sample, you will need to modify the `backend.tf` and set your `dynamodb_table` and `bucket` for terraform. 

#### Reference 
The resource information below is basic and and is only what was used in this section. The full scope of this resource can be found [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

This is the simple header for the resource, and reference name should be replaced, and be uniquie for each bucket within the same plan. 
`resource “aws_s3_bucket” “reference_name” {}`

S3 buckets do require names, but if you do not set a `bucket` then terraform will assign a name. The name must be less than 63 charartiers and only contain lower case letters, numbers and dashes (`-`) . 

`bucket = "myfirstniftybucketforlogs"`

The Access Control list is used to determine what type of access the bucket should have, it can be `private`, `public-read`, `public-read-write`, `aws-exec-read`, `authenticated-read`, and `log-delivery-write`

`acl = "private"`

If you want to recover items that are deleted or if you have to have version control on individual items you should enable `versioning`

```
versioning {
    enabled = "true"
}
```

For our example we have `AES256` set on the buckets for encryption. This is done with the `server_side_encryption_configuration` rule. This will enable encryption to all objects by default.

Inside the `rule` we have the `apply_server_side_encryption_by_default` and even though this sounds like it should be yes or no, it 

The next item is the `sse_algorithm` and for that, we specify the `AES256` 


```
server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256" 
        }
    }
}
```


Life Cycle is a good way to migrate things to cheaper storage after a time or use case. In our example we are going to use the `lifecycle_rule` to just migrate the data down to less expensive storage after a set amount of time. 

In the opening block you will need to give your rule a name, in this case `id`, and these need to be unique for the bucket, but you can have multiple `lifecycle_rule` sets 

You will also need to set the `enable` block to have the rule function or not. 
Now we move on to the `transition` items. What we want to do is have the the data in the buckets transition to lower level storage then be deleted after a set amount of time. The times listed below are the minimum for each level. 

For this example we are going to use the following classes, other classes are listed in the [AWS documetion](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html) or the Terraform `aws_s3_bucket` [Resource Page](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) 
* STANDARD_IA - Standard Infrequent Access storage
* GLACIER - Slower storage used for archiving items 

After a determined amount of time we want to remove the contents in the bucket, and to do that `expire` is set. This will delete the items in this bucket.


```
lifecycle_rule {
    id = "Rule_ID"
    enable = "true"
    
    transition {
        days = "30"
        storage_class = "STANDARD_IA"
    }

    transition {
        days = "30"
        storage_class = "GLACIER"
    }

    expiration {
        days = "90"
    }
}
```
