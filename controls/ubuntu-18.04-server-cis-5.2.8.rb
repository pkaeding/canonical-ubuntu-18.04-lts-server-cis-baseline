# encoding: UTF-8

control "C-5.2.8" do
  title "Ensure SSH IgnoreRhosts is enabled"
  desc  "The `IgnoreRhosts` parameter specifies that `.rhosts` and `.shosts`
files will not be used in `RhostsRSAAuthentication` or
`HostbasedAuthentication`."
  desc  "rationale", "Setting this parameter forces users to enter a password
when authenticating with ssh."
  desc  "check", "
    Run the following command and verify that output matches:

    ```
    # sshd -T | grep ignorerhosts

    IgnoreRhosts yes
    ```
  "
  desc "fix", "
    Edit the `/etc/ssh/sshd_config` file to set the parameter as follows:

    ```
    IgnoreRhosts yes
    ```
  "
  impact 0.5
  tag severity: "medium"
  tag nist: ["CM-7 (1)", "Rev_4"]
  tag cis_level: 1
  tag cis_controls: ["9.2", "Rev_7"]
  tag cis_rid: "5.2.8"
  describe parse_config_file('/etc/ssh/sshd_config', { assignment_regex: /^\s*(\S*)\s*(.*?)\s*$/ } ) do
    its('IgnoreRhosts') { should cmp 'yes' }
  end
end
