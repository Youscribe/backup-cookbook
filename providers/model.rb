action :create do
  cron_d new_resource.name do
    hour new_resource.hour || "1" 
    minute new_resource.minute || "*"
    day new_resource.day || "*"
    month new_resource.month || "*"
    weekday new_resource.weekday || "*"
    user new_resource.user if new_resource.user
    mailto new_resource.mailto
    command backup_command(new_resource.name)
    path ENV['PATH']
    action :create
  end
  new_resource.updated_by_last_action(true)

  template "Model File" do
    path ::File.join( node['backup']['conf_dir'], new_resource.name + '.rb')
    mode 0600
    source "generic_model.conf.erb"
    cookbook "backup"
    variables(
      :name => new_resource.name, 
      :description => new_resource.description,
      :definition => new_resource.definition
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
