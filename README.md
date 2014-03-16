# Configue
Configue is a configuration / settings solution that uses YAML files.
It is almost a fork of SettingsLogic.
Configue can read multiple YAML files and you can use big configration data
simply.

## Installation
```
gem install configue
```

## Usage
### Define your class
```ruby
class Conf < Configue::Container
  config_setting.source_dir "#{File.dirname(__FILE__)}/config"
end
```
