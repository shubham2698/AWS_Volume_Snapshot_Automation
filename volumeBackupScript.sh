#!/bin/bash
read -p "Enter file name : " filename;
cat ${filename} | while read f1 f2 f3;
	f1=$(echo "${f1}");
	f2=$(echo "${f2}");
	f3=$(echo "${f3}");
do
for id in $(aws ec2 describe-instances --query Reservations[*].Instances[*].[InstanceId] --region "$f1" --profile "$f2" --output text);
do
id=$(echo "${id}")
Project_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$id" "Name=key,Values=Project" --query Tags[0].Value --profile "$f2" --region "$f1");
if [[ "$Project_name" =~ "${f3}" ]];
then
	for vid in $(aws ec2 describe-volumes --filters "Name=attachment.instance-id,Values=$id" --query Volumes[*].Attachments[*].VolumeId --region "$f1" --profile "$f2" --output text);
	do
	vid=$(echo "${vid}")
	instance_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$id" "Name=key,Values=Name" --query Tags[0].Value --output text --profile "$f2" --region "$f1");
	snapshot_id=$(aws ec2 create-snapshot --volume-id $vid --description "${instance_name}-SNAPSHOT `date`" --output text --profile "$f2" --region "$f1");
	echo $instance_name $vid $snapshot_id;

done
fi
done
done