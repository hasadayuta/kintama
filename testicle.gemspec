# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{testicle}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Adam"]
  s.date = %q{2010-12-08}
  s.email = %q{james@lazyatom.com}
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md", "test/aliases_test.rb", "test/assertions_test.rb", "test/automatic_running_test.rb", "test/exceptions_test.rb", "test/method_behaviour_test.rb", "test/runner_test.rb", "test/setup_test.rb", "test/teardown_test.rb", "test/test_and_subcontext_access_test.rb", "test/test_helper.rb", "test/testicle_test.rb", "lib/testicle/aliases.rb", "lib/testicle/assertions.rb", "lib/testicle/context.rb", "lib/testicle/runner.rb", "lib/testicle/test.rb", "lib/testicle/test_environment.rb", "lib/testicle.rb"]
  s.homepage = %q{http://github.com/lazyatom}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{It's for writing tests.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end