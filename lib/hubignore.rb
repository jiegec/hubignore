require 'colored'
require 'hubignore/version'
require 'net/http'
require 'uri'

# The main class of HubIgnore
class HubIgnore
  def run(argv)
    unless File.exist?('.gitignore')
      puts 'No .gitignore file in current directory. Exiting.'
      return
    end
    parse_argv(argv)
  end

  def parse_argv(argv)
    help = <<EOS
$ hubignore -v --version # show version
$ hubignore -l --list # list git ignores in current .gitignore
$ hubignore -u --update # update git ignores in current .gitignore to upstream
$ hubignore -h --help # show this help message
EOS

    case argv
    when ['-l'], ['--list']
      list
      exit
    when ['-u'], ['--update']
      update
      exit
    when ['-v'], ['--version']
      puts "hubignore #{HubIgnore::VERSION}"
      exit
    when ['-h'], ['--help']
      puts help
      exit
    else
      puts help
      exit 1
    end
  end

  def items
    items = []
    file = IO.read('.gitignore')
    file.scan(/\#\# HubIgnore Begin:.*?\#\# HubIgnore End./m).each do |block|
      first_line = block.lines.first
      items << first_line.split(':')[1].split(',').map(&:strip)
    end
    items
  end

  def list
    puts 'These are the ignores in you .gitignore file:'
    puts items.flatten
  end
  
  def update
    items.each do |item|
      content = "\#\# HubIgnore Begin: #{item.join(', ')}\n"
      item.each do |file|
        next if file.empty?
        puts "Downloading #{file}"
        content += "\#\# #{file} Begins:\n"
        content += Net::HTTP.get(
          URI.parse(
            'https://raw.githubusercontent.com/github/'\
            "gitignore/master/#{file}.gitignore"))
        content += "\n"
      end
      item.map! do |name|
        Regexp.escape(name)
      end
      content += '## HubIgnore End.'
      file = IO.read('.gitignore')
      file = file.gsub(
        /\#\# HubIgnore Begin: *#{item.join(' *, *')} *.*?\#\# HubIgnore End./m,
        content)
      IO.write('.gitignore', file)
    end
  end
end
