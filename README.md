To Create an Snapshot of instances that belongs to one project.
Auto filter out the particular instances of project.
Create an Snapshot of all the volumes attached with it.

Input :
f1 = aws_region
f2 = aws_profile 
f3 = Project_name_tag


Execute the script and it will create an sanpshot of volumes attached with instances for the instance with Project_name matched.

Output : 

instnace-id, snapshot_id