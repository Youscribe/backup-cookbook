package "libxslt" do
  package_name "libxslt-dev"
  action :install
end

package "libxml-dev" do
  package_name "libxml2-dev"
  action :install
end

gem_package "backup" do
    version '~> 3.0'
    action :install
end

['s3sync', 'fog', 'mail', 'whenever', 'popen4'].each do |gem_name|
  gem_package gem_name do
    action :install
  end
end
