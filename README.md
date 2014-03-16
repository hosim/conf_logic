# Configue
Configue is a configuration / settings solution that uses YAML files.
It is almost a fork of SettingsLogic.
Configue can read multiple YAML files and you can use big configuration data
simply.

## Installation
```
gem install configue
```

## Usage
### Define your class
```ruby
class MyConf < Configue::Container
  config_setting.source_dir "#{File.dirname(__FILE__)}/config"
end
```

### Write your settings in YAML file
```yaml
# config/accounts/admin_users.yml
config:
  accounts:
    admin_users:
      - grumpy
      - sneezy
```
```yaml
# config/accounts/test_users.yml
config:
  accounts:
    test_users:
      - sleepy
      - dopey
```
    
