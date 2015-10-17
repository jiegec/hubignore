# -*- encoding: utf-8 -*-
require_relative 'lib/hubignore/version'

Gem::Specification.new do |s|
  s.name        = 'hubignore'
  s.version     = HubIgnore::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jiege Chen']
  s.email       = ['jiegec@qq.com']
  s.homepage    = 'https://github.com/jiegec/hubignore'
  s.summary     = 'Download and manage git ignores from github/gitignore.'
  s.license     = 'MIT'

  s.files        = Dir.glob('{bin,lib,man}/**/*') + %w(LICENSE README.md)
  s.require_path = 'lib'
  s.executables  = Dir.glob('bin/*').map(&File.method(:basename))
end
