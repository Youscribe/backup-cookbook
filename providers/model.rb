action :backup do
  include_recipe "cron"
  cron_d new_resource.name do
    hour new_resource.hour || "1" 
    minute new_resource.minute || "*"
    day new_resource.day || "*"
    month new_resource.month || "*"
    weekday new_resource.weekday || "*"
    user new_resource.user if new_resource.user
    mailto new_resource.mailto
    command backup_command(new_resource.name)
    action :create
  end
  new_resource.updated_by_last_action(true)

  template "Model File" do
    path ::File.join( node['backup']['conf_dir'], new_resource.name + '.rb')
    mode 0600
    source new_resource.options["source"] || "generic_model.conf.erb"
    cookbook new_resource.options["cookbook"] || "backup"
    variables(
      :name => new_resource.name, 
      :options => new_resource.options,
      :split_into_chunks_of => new_resource.split_into_chunks_of,
      :description => new_resource.description,
      :backup_type => new_resource.backup_type,
      :database_type => new_resource.database_type,
      :store_with => new_resource.store_with,
      :password => new_resource.password
    )
    notifies :create, resources(:cron_d => new_resource.name), :immediately
  end
  new_resource.updated_by_last_action(true)
end

action :disable do
  cron_d current_resource.name do
    action :remove
  end
  new_resource.updated_by_last_action(true)
end

action :remove do
  file ::File.join( node['backup']['conf_dir'], name + '.rb') do
    action :remove
  end
  cron "scheduled backup: " + current_resource.name do
    action :remove
  end
  new_resource.updated_by_last_action(true)
end