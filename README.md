# Configue
Configue is a configuration / settings solution that uses YAML files.
It is almost a fork of SettingsLogic.
Configue can read multiple YAML files and you can use big configuration data
simply.

## Installation
```
gem install configue
```

## Basic Usage
### Define your class
```ruby
class MyConf < Configue::Container
  config.source_dir "#{File.dirname(__FILE__)}/config"
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

You can make multiple settings files.

```yaml
# config/accounts/test_users.yml
config:
  accounts:
    test_users:
      - sleepy
      - dopey
```

### Access your settings
```
>> MyConf.config.accounts.admin_users
=> ["grumpy", "sneezy"]

>> MyConf.config.accounts.test_users
=> ["sleepy", "dopey"]
```

## Other usage
### namespace
You can specify `namespace` and `base_namespace`.

When you write settings as follows:
```yaml
# config/settings/base.yml
base:
  foo:
    baa:
      - a
      - b
      - c
    baz:
      - one
      - two
      - three

# config/settings/dev.yml
dev:
  foo:
    baa:
      - pee
      - kaa
      - boo

# config/settings/test.yml
test:
  foo:
    baa:
      - boo
      - foo
      - woo
```
and define a class for the settings
```ruby
class MyConf < Configue::Container
  config.source_dir "#{File.dirname(__FILE__)}/config/settings"
  config.base_namespace :base
  config.namespace :test
end
```
you can access it in the following manner:
```
>> MyConf.foo.baa
=> ["boo", "foo", "woo"]

>> MyConf.foo.baz
=> ["one", "two", "three"]
```
