### Basics 
With this plan it will allow you to create a simple s3 hosted website. The code for the site itself is not here. <br>
An s3 bucket can host a simple web site with varying levels of static content. 


There is an associated youtube video with this content [here](https://www.youtube.com/watch?v=AOuha5eC9jw) and blog post [here](http://www.hifighetto.com/2021/01/terraform-s3-hosted-site.html) (The blog post will just echo what is in this readme file)

Again with the catches to having a bucket: 

    Bucket names must be DNS compatible. No special characters
    New bucket names are s3.region vs old ones were s3-region 
    Bucket names must be 100% unique, you cannot name it the same as another accounts
 

```
resource "aws_s3_bucket" "reference_name" {}
```

Starting with a general resource

Replace `reference_name` with how you want to reference the bucket in other locations. 

 
```
  bucket = var.project_name
  acl    = "public-read"
```

 In our block we want to start by first giving the bucket a name, and an Access Control List permissions.  

We have set the permissions in the ACL  to `public-read`, this will allow everyone to read the contents of the bucket and any web pages that you have in the bucket. Remote web browsers cannot view the general contents of a bucket, only explicit files directly. 

For the policy section we are going to use a `templatefile` to put a custom attribute in for the bucket name. 


```
  policy = templatefile("site-policy.json", { project_name = var.project_name} )
```
This will allow us to use this template for other projects because we are not hard coding information. 

For the template file, it reads as `filename.json`
```
 { first_variable = var.value, second_variable = var.value2 } 
```
You are also able to use a map for the values in the template. More information can be found [here](https://www.terraform.io/docs/configuration/functions/templatefile.html)

```
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
```

If you have requirements that use Server Side Encryption, SSE, here is where you would configure it. With this example we are going to use AES256, also known as the amazon default encryption.
You do not have to use the AWS default encryption, but for our example and budget, we are going to use AES-256. Some other options are Amazon S3 managed  keys or Customer Master Keys. More can be read about them here. 

```
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
```

In this section we have the `website` files. These are the files we will use for our default document, "index.html" and for our errors, or 404 page. 

Setting an `error_document` will also prevent outside browsers from being able to have an generic s3 error message returned so that they can return to your web site/page easier. 