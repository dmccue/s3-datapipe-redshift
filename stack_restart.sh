#!/bin/bash

function ansibleError {
  echo "Error: Ansible did not finish successfully"
  exit 1
}

# Create Stack
ansible-playbook -v ansible/cloudformation.yml || ansibleError


# ----------------- no longer used -----------------
# rsEndpoint=$(aws cloudformation describe-stacks --stack-name ${stackname} --output text --query "Stacks[0].Outputs[?OutputKey=='outRSEndpoint'].OutputValue")
# rsEndpointPort=$(aws cloudformation describe-stacks --stack-name ${stackname} --output text --query "Stacks[0].Outputs[?OutputKey=='outRSEndpointPort'].OutputValue")
# rsDatabaseName=$(aws cloudformation describe-stacks --stack-name ${stackname} --output text --query "Stacks[0].Outputs[?OutputKey=='outRSDatabaseName'].OutputValue")
# rsMasterUsername=$(aws cloudformation describe-stacks --stack-name ${stackname} --output text --query "Stacks[0].Outputs[?OutputKey=='outRSUsername'].OutputValue")
# rsMasterUserPassword=$(aws cloudformation describe-stacks --stack-name ${stackname} --output text --query "Stacks[0].Outputs[?OutputKey=='outRSPassword'].OutputValue")
#
# echo Please run the following to verify tables have been created:
# cmdToRun="PGPASSWORD=${rsMasterUserPassword} psql -h ${rsEndpoint} -p ${rsEndpointPort} -U ${rsMasterUsername} -d ${rsDatabaseName} -c '\d'"
# echo Running: ${cmdToRun}
# eval ${cmdToRun}
#
# echo Please run the following to verify tables have been populated:
# cmdToRun="PGPASSWORD=${rsMasterUserPassword} psql -h ${rsEndpoint} -p ${rsEndpointPort} -U ${rsMasterUsername} -d ${rsDatabaseName} -c 'select * from test_users;'"
# echo Running: ${cmdToRun}
# eval ${cmdToRun}

# PipelineRef=$(aws cloudformation describe-stacks --stack-name ${stackname} --output text --query "Stacks[0].Outputs[?OutputKey=='outPipelineRef'].OutputValue")
# echo "PipelineRef: ${PipelineRef}"
# echo "aws datapipeline list-runs --pipeline-id ${PipelineRef}"

# Upload csv contents triggering import via datapipeline
# cat data/data.csv | aws s3 cp - s3://dsm-s3toredshift/incoming/$(date +%s).csv


# aws cloudformation describe-stacks --stack-name ${stackname}
# echo -------------------
# aws cloudformation describe-stack-resources --stack-name ${stackname}



# echo Please run the following to create tables:
# cmdToRun="PGPASSWORD=${rsMasterUserPassword} psql -h ${rsEndpoint} -p ${rsEndpointPort} -U ${rsMasterUsername} -d ${rsDatabaseName} -a -w -f ${dataFile}"
# echo Running: ${cmdToRun}
# eval ${cmdToRun}

# echo Please run the following to verify tables have been created:
# cmdToRun="PGPASSWORD=${rsMasterUserPassword} psql -h ${rsEndpoint} -p ${rsEndpointPort} -U ${rsMasterUsername} -d ${rsDatabaseName} -c '\d'"
# echo Running: ${cmdToRun}
# eval ${cmdToRun}

# read -p "Continue? [Y/n] : " response


# # Create Pipeline
# pipelineName=dsm-test
# pipelineID=$(aws datapipeline list-pipelines --output text | grep -E "\t${pipelineName}$" | cut -f2)
# # Create Pipeline
# aws datapipeline list-pipelines --output text | grep dsm-test
# pipelineName=copy_s3_csv_to_redshift
# pipelineDef=functions//csvToRS.json
# pipelineID=$(aws datapipeline list-pipelines --output text | grep ${pipelineName} | cut -f2)
# [ "${pipelineID}" ] && \
# aws datapipeline delete-pipeline --pipeline-id ${pipelineID}
# aws datapipeline create-pipeline --name ${pipelineName} --unique-id ${pipelineName}
# pipelineID=$(aws datapipeline list-pipelines --output text | grep ${pipelineName} | cut -f2)
# aws datapipeline put-pipeline-definition --pipeline-definition file://${pipelineDef} --parameter-values \
# myInputTsvFilesS3Loc=<s3://tsv-files-insert-loc> \
# myRedshiftJdbcConnectStr=<jdbc:postgresql://${rsEndpoint}:${rsEndpointPort}/${rsDatabaseName}?tcpKeepAlive=true> \
# myRedshiftUsername=${rsMasterUsername} \
# myRedshiftPassword=${rsMasterUserPassword} \
# myRedshiftTableName=<target-redshift-tablename> \
# myRedshiftSecurityGrpIds=<sg-blah> \
# --pipeline-id ${pipelineID}
# aws datapipeline activate-pipeline --pipeline-id ${pipelineID}
# sleep 5
# aws datapipeline list-runs --pipeline-id ${pipelineID}
# ec2floatingip=$(aws cloudformation describe-stacks --stack-name ${stackname} --query "Stacks[0].Outputs[?OutputKey=='InstanceIPAddress'].OutputValue" --output text)
# ssh -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/Downloads/dmccue-eu-west.pem ec2-user@${ec2floatingip} uptime && \
# echo Successful ssh connection
