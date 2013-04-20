# mysql adjustments for munin - create monitoring user; TODO: later on, load the user from data bags

template "/tmp/mysql_monitoring_munin.sql" do
  source "mysql_monitoring_munin.sql.erb"
end

bash "mysql_monitoring_settings" do

  not_if("/usr/bin/mysql -uroot -p#{node[:mysql][:server_root_password]} mysql -e'select user from user' | grep monitoring", :user => 'root')
  user "root"
  code <<-EOH
    /usr/bin/mysql -uroot -p#{node[:mysql][:server_root_password]} < /tmp/mysql_monitoring_munin.sql
  EOH
end
