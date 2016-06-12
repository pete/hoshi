require 'rubygems/package_task'
require 'rdoc/task'

spec = Gem::Specification.new { |s|
	s.platform = Gem::Platform::RUBY

	s.author = "Pete Elmore"
	s.email = "pete@debu.gs"
	s.files = Dir["{lib,doc,bin,ext}/**/*"].delete_if {|f| 
		/\/rdoc(\/|$)/i.match f
	} + %w(Rakefile README)
	s.require_path = 'lib'
	s.has_rdoc = true
	s.extra_rdoc_files = Dir['doc/*'].select(&File.method(:file?))
	s.extensions << 'ext/extconf.rb' if File.exist? 'ext/extconf.rb'
	Dir['bin/*'].map(&File.method(:basename)).map(&s.executables.method(:<<))

	s.name = 'hoshi'
	s.rubyforge_project = 'hoshi-view'
	s.summary = "Nice, object-oriented, first-class views."
	s.homepage = "http://debu.gs/#{s.name}"
	%w(hpricot).each &s.method(:add_dependency)
	s.version = '1.0.3'
}

Gem::PackageTask.new(spec) { |pkg|
	pkg.need_tar_bz2 = true
}

task(:install => :package) { 
	g = "pkg/#{spec.name}-#{spec.version}.gem"
	system "sudo gem install -l #{g}"
}

task(:test) {
	system "ruby test/run.rb"
}
