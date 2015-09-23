service 'jenkins' do
  supports status: true, restart: true, reload: true
  action  [:enable]
end

cookbook_file 'jenkins-config.tar.gz' do
  path '/tmp/jenkins-config.tar.gz'
  owner 'root'
  group 'root'
  mode '644'
end

bash 'cleanup jenkins-config' do
  code 'rm -rf /var/lib/jenkins/*.xml /var/lib/jenkins/jobs'
end

bash 'extract jenkins-config' do
  user 'jenkins'
  group 'jenkins'
  code 'tar xvz -f /tmp/jenkins-config.tar.gz -C /var/lib/jenkins'
  notifies :restart, 'service[jenkins]', :immediately
end
