Gem::Specification.new do |s|
  s.name = "mini"
  s.version = "0.9.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = %w{ Rany Keddo }
  s.date = "2009-03-01"
  s.email = "purzelrakete@gmail.com"
  s.extra_rdoc_files = %w{ README.markdown }
  s.files = ["CREDITS.markdown", "LICENSE.markdown", "README.markdown", "TODO.markdown", "bin/minigen", "lib/mini", "lib/mini/bot.rb", "lib/mini/irc.rb", "lib/mini/listener.rb", "lib/mini/web.rb", "lib/mini.rb", "scripts/minicmd.erb", "scripts/minictl.erb",]
  s.has_rdoc = false
  s.rdoc_options = ["--line-numbers", "--inline-source"]
  s.homepage = "http://github.com/purzelrakete/mini"
  s.require_paths = %w{ lib }
  s.requirements = %w{ eventmachine activesupport sinatra }
  s.rubygems_version = "1.3.1"
  s.executables = %w{ minigen }
  s.summary = "a ruby eventmachine bot inspired by richard jones' irccat. interact via netcat, irc or web."
end
