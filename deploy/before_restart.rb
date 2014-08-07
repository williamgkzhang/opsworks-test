def create_secrets(secrets, release_path)
  Chef::Log.info("Creating secrets")
  file_path = ::File.join(release_path, 'config/secrets.yml')
  ::File.open(file_path, 'w') do |f|
    f.write("production:\n")
    secrets.each do |k,v|
      f.write("  #{k}: #{v}\n")
    end
  end
end
def set_env(secrets)
  Chef::Log.info("Creating Environment Variables")
	secrets.each do |k,v|
		ENV[k] = v
		Chef::Log.info("...:#{k}")
	end
end

node[:deploy].each do |application, deploy|
  create_secrets(deploy[:secrets], release_path)
  set_env(deploy[:secrets])
end	
