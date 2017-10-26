Threat Stack Support Tools

# Check out this branch on Github and run `diagnostics.sh`

## Master Script Overview

Running the `diagnostics.sh` master script gathers system information. It calls the following child scripts and runs a series of commands that:
- `gather_system_info.sh`: returns information about the host system (such as OS version, kernel version, and system uptime)
- `gather_agent_info.sh`: returns information about the agent installed on the host system (such as agent version, the output of `cloudsight status`, and the contents of `config.json`)
- `gather_docker_info.sh`: returns information if Docker is installed and located
- `gather_fim_info.sh`: returns information about the agent's FIM services

`diagnostics.sh` outputs the results of each of these scripts to a file in `/tmp`. Then it copies several files from `/opt/threatstack/cloudsight/logs` to the same directory, and tars that directory together. The resulting file saves in your current working directory in .tar.gz format, named `ts_logs_<CURRENT_DATE>.tar.gz`. An example of the name `ts_logs_05-25-2017.tar.gz`. Finally, using the included support.pub, the script encrypts the newly created tarball (you can override the encryption process by using the --send-unsafe flag). 

For full terms and conditions of usage, please refer to the following: https://www.threatstack.com/terms/
