# background jobs

# uses .net remoting. parent/child relationship
# use start-job or use -AsJob parameter, supported by many commands

$procjob = start-job {get-process}
$procjob # displays state of job

get-job # lists all jobs, by id, name, state, time
wait-job
stop-job
remove-job
receive-job $myresults -Keep # get results back from job

# scheduled tasks

# PSScheduledJob module

# Scheduled job definition is stored to disk in:
# C:\users\eric\appdata\local\microsoft\powershell\scheduledjobs<jobname>
# Results are also written to disk in the same location
# Define job trigger - frequency and time
# Define job action - script block or file
# Register job

$trigger = new-jobtrigger -daily -at "6:00 am"
$action = {code here}
$option = new-scheduledjob
-name "event"
-scriptblock $action
-trigger $trigger
-scheduledjoboption $option

disable-scheduledjob 
enable-scheduledjob 
unregister-scheduledjob myjob

new-pssession



