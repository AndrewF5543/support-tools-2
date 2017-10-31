Threat Stack Support Tools

# Check out this branch on Github and run `diagnostics.sh`

## Master Script Overview

To use the support tool, please run `sudo bash diagnostics.sh`.
NOTE: You must use `bash` in order for the script to execute properly. `sh` doesn't work in this case.

Running the `diagnostics.sh` master script gathers system information. It calls the following child scripts and runs a series of commands that:
- `gather_system_info.sh`: returns information about the host system (such as OS version, kernel version, and system uptime)
- `gather_agent_info.sh`: returns information about the agent installed on the host system (such as agent version, the output of `cloudsight status`, and the contents of `config.json`)
- `gather_docker_info.sh`: returns information if Docker is installed and located
- `gather_fim_info.sh`: returns information about the agent's FIM services

`diagnostics.sh` outputs the results of each of these scripts to a file in `/tmp`. Then it copies several files from `/opt/threatstack/cloudsight/logs` to the same directory, and tars that directory together. The resulting file saves in your current working directory in .tar.gz format, named `ts_logs_<CURRENT_DATE>.tar.gz`. An example of the name `ts_logs_05-25-2017.tar.gz`. Finally, using the included support.pub, the script encrypts the newly created tarball.

A note regarding the usage of GPG: In order to protect potentially sensitive data, Threat Stack uses GPG to encrypt the tarball that this process generates. In doing so, it will add the Threat Stack Support public key to the key ring on the server, which can be removed after the script has been executed. Because the public key comes from an unrecognized source, the script outputs a warning that the key is untrusted, and will prompt you to continue with the encryption or to abort the process. In this instance, it's safe to proceed. If you have any questions or concerns about the security of this method, you may use the --send-unsafe flag (which will cause the encryption step to be skipped) and discuss alternative methods with our Support team.

For full terms and conditions of usage, please refer to the following: https://www.threatstack.com/terms/
