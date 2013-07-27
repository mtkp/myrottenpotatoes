# For loading ENV variables from config/local_env.yml

YAML.load_file(Rails.root.join('config', 'local_env.yml')).each do |key, value|
  ENV[key.to_s] = value
end unless Rails.env =~ /production/
