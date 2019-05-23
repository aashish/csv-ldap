# Csv::Ldap

Csv::Ldap for Ruby is a gem for reading/writing entries in an LDAP directory to/from CSV files. The tool should be able to create entries in a directory under `ou=people,dc=example,dc=org` from a CSV file with the following attributes: `cn,sn,mail,uid,homeDirectory,uidNumber,gidNumber`.

Note: This documentation is based on Ubuntu 14.04 LTS

## Pre-Requisites

Install OpenLDAP server.

```
sudo apt install slapd ldap-utils
```

Configure with following

```
sudo dpkg-reconfigure slapd
```

After configuring the slapd. Create a node called 'people'.

Create the following LDIF file and call it add_content.ldif:

```
dn: ou=people,dc=example,dc=org
objectClass: organizationalUnit
ou: people
```

Add the content by run the following command from terminal

```
ldapadd -x -D cn=admin,dc=example,dc=com -W -f add_content.ldif

Enter LDAP Password: ********
adding new entry "ou=people,dc=example,dc=org"
```

Entries will be created in a directory under `ou=people,dc=example,dc=org`

Refer to following for more details

https://help.ubuntu.com/lts/serverguide/openldap-server.html.en#openldap-server-installation

https://www.unixmen.com/install-openldap-in-ubuntu-15-10-and-debian-8/

## Installation

Add this line to your application"s Gemfile:

```ruby
gem 'csv-ldap'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv-ldap

## Features
- Create entries in an LDAP directory from a CSV file.
- Export entries returned from an LDAP search to a CSV file. The search filter should come from a command line argument.

## Usage

Make sure to run and confirm that node 'people' exists.

```
$ ldapsearch -x -LLL -H ldap:/// -b dc=example,dc=org dn
dn: dc=example,dc=org

dn: cn=admin,dc=example,dc=org

dn: ou=people,dc=example,dc=org
```

### Write in ldap from csv.

```
$ cd csv-ldap
$ ruby examples/csv_to_ldap.rb csv-ldap/examples/ldap_data.csv
```

### Read from ldap to csv.

```
$ ruby examples/ldap_to_csv.rb output.csv
```

### Seach with filter from ldap to csv.

```
$ ruby examples/ldap_to_csv_filtered.rb ldap_to_csv_filtered_output.csv John*

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/csv-ldap. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Csv::Ldap project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/csv-ldap/blob/master/CODE_OF_CONDUCT.md).
