Description
===========

This cookbook aims to provide a foundation for you to **backup** your infrastructure.  This cookbook helps you deploy the [backup](https://github.com/meskyanichi/backup) gem and generate the models to back up.

Requirements
============

Ruby installed either in the system or via omnibus

Resources and Providers
=======================

`model`
-------------

Generates a model file for the backup gem and creates a cron entry.

Actions:

* `create` - Generate a model file 
* `disable` - Disable the scheduled cron for the model
* `remove` - Remove the model from the system and the scheduled cron.


Attribute Parameters:

* `split_into_chunks_of` - Fixnum - defaults to 250  
* `description` - String - Description of backup
* `definition` - String - Definition of the backup in backup language
* `hour` - String - Hour to run the scheduled backup - default - `1`  
* `minute` - String - Minute to run the scheduled backup - default - `*`  
* `day` - String - Day to run the scheduled backup - default - `*`  
* `weekday` - String - Weekday to run the scheduled backup - default - `*`  
* `mailto` - String - Enables the cron resource to mail the output of the backup output.
* `user` - String - User used to launch backup


Usage
=====

There is an ininite ways you can implement this cookbook into your environment in theory.  An working example might be,

* Backing up MySQL to S3

```
include_recipe "backup"

backup_model :my_db do
  description "Back up my database"

  definition <<-EOH
    split_into_chunks_of 4000

    database MySQL do |db|
      db.name = 'mydb'
      db.username = 'myuser'
      db.password = '#{node['mydb']['password']}' # will be interpolated
    end

    compress_with Gzip

    store_with S3 do |s3|
      s3.access_key_id = '#{node['aws']['access_key_id']}'
      s3.secret_access_key = '#{node['aws']['secret_access_key']}'
      s3.bucket = 'mybucket'
    end
  EOH
  mailto "sample@example.com"  
  action :create  
end
```

License and Author
==================

Author:: Scott Likens (<scott@likens.us>)

Copyright 2012, Scott M. Likens, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0
    
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
    
    
Special Credit and Thanks
==================

Thank You [Heavy Water](hw-ops.com) for contributing the original [backup](https://github.com/hw-cookbooks/backup) cookbook.  
