# ConfLogic
ConfLogic is a configuration / settings solution that uses YAML files.
As its name it is almost a fork of SettingsLogic.
ConfLogic can read multiple YAML files and you can use big configration data
simply.

## Installation
```
gem install conf_logic
```

## Usage
### Define your class
```ruby
class Conf < ConfLogic::Container
  conf_setting.source_dir "#{File.dirname(__FILE__)}/config"
end
```
