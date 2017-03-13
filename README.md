# s3-datapipe-redshift
Cloudformation - S3 to DataPipeline to Redshift using python lambda trigger

Please ensure ansible, awscli, boto and psql are configured.
Tested with Ansible 2.3.0, boto3 1.4.4, psql 9.6.2 and awscli 1.11.61.

```bash
git clone https://github.com/dmccue/s3-datapipe-redshift.git && cd s3-datapipe-redshift
vi ansible/vars.yml

To create application:
  ./stack_update.sh
  
To delete application
  ./stack_delete.sh
```

Please see https://cloudwheel.wordpress.com/2017/03/13/aws-cloudformation-for-s3-import-to-redshift-using-datapipeline-lambda/ for a full description
