package "libxslt" do
  package_name "libxslt-dev"
  action :install
end

package "libxml-dev" do
  package_name "libxml2-dev"
  action :install
end


['backup', 's3sync', 'fog', 'mail', 'whenever', 'popen4'].each do |gem_name|
  chef_gem gem_name do
    action :install
  end
end
