# Configue
Configue is a configuration / settings solution that uses YAML files.
It is almost a fork of [SettingsLogic](https://github.com/binarylogic/settingslogic).
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

### source_file
You can specify files that you want to load into your class in the following manner:

```ruby
class MyConf < Configue::Container
  config.source_file "#{File.dirname(__FILE__)}/config/settings/base.yml"
  config.source_file "#{File.dirname(__FILE__)}/config/settings/dev.yml"
  config.source_file "#{File.dirname(__FILE__)}/config/settings/test.yml"

  ...
```

### support ERB tag
You can use ERB tags in YAML files.

```yaml
foo:
  baa:
    baz:
      - <%= ENV['foo'] %>
```

### import_config
You can import a configuration into an object as one of its attributes without
defining a class for that.

```ruby
class Foo
  include Configue::Importer
  import_config from_dir: "#{File.dirname(__FILE__)}/config/settings",
                as: :settings,
                namespace: :dev
  ...
  def foo
    if settings.foo.baa == ...
    ...
```
