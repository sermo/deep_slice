gem_name = 'deep_slice'
gem_version = DeepSlice::VERSION
gem_server = 'gems.sermo.cloud'
gem_tag = "v#{gem_version}"
gem_file = "#{gem_name}-#{gem_version}.gem"
gemspec_file = "#{gem_name}.gemspec"

local_gem_dir = 'pkg'
local_gem_path = "#{local_gem_dir}/#{gem_file}"
remote_gem_dir = '/tmp'
remote_gem_path = "#{remote_gem_dir}/#{gem_file}"

desc 'Build the gem'
task :build do
  system "mkdir -p #{local_gem_dir}"
  system "gem build #{gemspec_file} && mv #{gem_file} #{local_gem_dir}"
end

desc 'Uninstall the gem'
task :uninstall do
  system "gem uninstall -q #{gem_name} 2> /dev/null"
end

desc 'Install the gem'
task :install => [:build, :uninstall] do
  system "gem install #{local_gem_path}"
end

desc "Release the gem to to #{gem_server}"
task :release => [:build, :tag] do
  system "ssh -t #{gem_server} 'sudo rm -f #{remote_gem_path}'"
  system "scp #{local_gem_path} #{gem_server}:#{remote_gem_dir}"
  system "ssh -t #{gem_server} 'sudo mv #{remote_gem_path} /var/www/gems/gems/'"
  system "ssh -t #{gem_server} 'sudo /opt/ruby-1.9.3-p194/bin/gem generate_index -d /var/www/gems/'"
end

desc 'Tag the gem'
task :tag do
  system "git tag #{gem_tag}"
  system "git push origin #{gem_tag}"
end
