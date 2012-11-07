def backup_command(name)
  cmd = ""
  cmd += "backup perform"
  cmd += " --trigger #{name}"
  cmd += " --root-path #{node['backup']['conf_dir']}"
  cmd += " --data-path #{node['backup']['data_dir']}"
  cmd += " --log-path #{node['backup']['log_dir']}"
  cmd += " --tmp-path #{node['backup']['tmp_dir']}"
  cmd += " --cache-path #{node['backup']['cache_dir']}"
  cmd += " --config-file #{::File.join(node['backup']['conf_dir'], name + '.rb')}"
  return cmd
end

def sanitize_filename(filename)
  returning filename.strip do |name|
   # NOTE: File.basename doesn't work right with Windows paths on Unix
   # get only the filename, not the whole path
   name.gsub!(/^.*(\\|\/)/, '')

   # Strip out the non-ascii character
   name.gsub!(/[^0-9A-Za-z.\-]/, '_')
  end
end
