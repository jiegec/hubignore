task :gem do
  sh 'rm -rf pkg'
  sh 'mkdir pkg'
  sh 'gem build hubignore.gemspec'
  sh 'mv hubignore-*.gem pkg'
  puts 'Built ' + Dir.glob('pkg/*.gem')[0]
end

task :install do
  sh 'gem install ' + Dir.glob('pkg/*.gem')[0]
end
