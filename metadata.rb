maintainer       "Scott M. Likens"
maintainer_email "scott@likens.us"
license          "Apache 2.0"
description      "Installs/Configures backup"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"
name             "backup"
%w{build-essential cron}.each do |cb|
  depends cb
end

suggests "ruby_installer"
suggests "bag_config"
suggests "discovery"

