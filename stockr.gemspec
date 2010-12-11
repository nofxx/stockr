# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{stockr}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcos Piccinini"]
  s.date = %q{2010-12-11}
  s.default_executable = %q{stockr}
  s.description = %q{Help keep track of stuff (good for electronics)}
  s.email = %q{x@nofxx.com}
  s.executables = ["stockr"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/stockr",
    "lib/stockr.rb",
    "lib/stockr/assets/bundle.js",
    "lib/stockr/export.rb",
    "lib/stockr/import.rb",
    "lib/stockr/part.rb",
    "lib/stockr/store.rb",
    "lib/stockr/web.rb",
    "spec/data/export.txt",
    "spec/spec_helper.rb",
    "spec/stockr/export_spec.rb",
    "spec/stockr/part_spec.rb",
    "spec/stockr_spec.rb"
  ]
  s.homepage = %q{http://github.com/nofxx/stockr}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Keep track of all your stuff}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/stockr/export_spec.rb",
    "spec/stockr/part_spec.rb",
    "spec/stockr_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, [">= 0"])
      s.add_runtime_dependency(%q<eletro>, [">= 0"])
      s.add_runtime_dependency(%q<multipart-post>, [">= 0"])
      s.add_development_dependency(%q<sinatra>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<redis>, [">= 0"])
      s.add_dependency(%q<eletro>, [">= 0"])
      s.add_dependency(%q<multipart-post>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<redis>, [">= 0"])
    s.add_dependency(%q<eletro>, [">= 0"])
    s.add_dependency(%q<multipart-post>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.1.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end
