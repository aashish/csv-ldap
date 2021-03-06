# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "csv/ldap/version"

Gem::Specification.new do |spec|
  spec.name          = "csv-ldap"
  spec.version       = Csv::Ldap::VERSION
  spec.authors       = ["Aashish Kiran"]
  spec.email         = ["aashish.kiran@gmail.com"]

  spec.summary       = %q{Csv::Ldap for Ruby is reading/writing entries in an LDAP directory to/from CSV files }
  spec.description   = %q{Csv::Ldap for Ruby is command-line interface tool for reading/writing entries in an LDAP
    directory to/from CSV files. The tool should be able to create entries in a directory under
    `ou=people,dc=example,dc=org` from a CSV file with the following
    attributes: `cn,sn,mail,uid,homeDirectory,uidNumber,gidNumber`.}
  spec.homepage      = "https://github.com/aashish/csv-ldap"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rubocop", "~> 0.49.0"
  spec.add_development_dependency "net-ldap", "~> 0.16.1"
end
