#
# Cookbook Name:: staf
# Recipe:: default
#
# Copyright 2014, Zend technologies 
#
# All rights reserved - Do Not Redistribute
#
#install staf
remote_file "/staf.bin" do
	  source "http://prdownloads.sourceforge.net/staf/STAF3416-setup-linux-amd64.bin?download"
	  mode "0744"
end
bash "install_staf" do
    user "root"
    cwd "/"
    code <<-EOH
        /staf.bin -i silent -DACCEPT_LICENSE=1 -DUPDATE_ENVIRONMENT=NONE
      EOH
end
#configure staf
cookbook_file "/etc/init.d/staf" do
	source "staf"
	mode "0644"
end
cookbook_file "/usr/local/staf/bin" do
	source "STAF.cfg"
	mode "0644"
end
#Start staf
service "staf" do
	[:start, :enable]
end
