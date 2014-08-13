if Rails.env.development?
  env_file = File.join(Rails.root, 'config', 'application.yml')
  hash = YAML.load_file(env_file)
  
  hash.each do |key, val|
    ENV[key] = val
  end
end