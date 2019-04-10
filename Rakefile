require 'rake'
require 'erb'
require 'fileutils'
require 'tempfile'
require 'pathname'

class InstallFile
  attr_accessor :src, :dest

  def initialize(hash)
    @hash = hash
    @src = Pathname.new(hash[:src])
    @dest = Pathname.new(hash[:dest].gsub('~', ENV['HOME']))
  end

  def link?
    @hash.fetch(:link, true)
  end

  def erb?
    @hash.fetch(:erb, false)
  end
end

desc "install the dot files into user's home directory"
task :install do
  files = [
    { src: 'zshrc', dest: '~/.zshrc', link: false },
    { src: 'gitconfig.erb', dest: '~/.gitconfig', erb: true },
    { src: 'gitignore', dest: '~/.gitignore' },
    { src: 'ackrc', dest: '~/.ackrc' },
    { src: 'irbrc', dest: '~/.irbrc' },
    { src: 'hgrc', dest: '~/.hgrc' },
    { src: 'tmux.conf', dest: '~/.tmux.conf' },
    { src: 'gdbinit', dest: '~/.gdbinit' },
    { src: 'init.vim', dest: '~/.config/nvim/init.vim' },
  ].map { |f| InstallFile.new(f) }

  files.each do |f|
    if !f.link? || f.erb?
      opts = f.erb? ? { erb: true } : {}
      install_file(f, opts)
    else
      install_link_file(f)
    end
  end
end

def install_link_file(f)
  if f.dest.exist?
    if f.dest.symlink? && f.dest.realpath == f.src.realpath
      puts "identical symlink #{f.dest}"

    else
      print "overwrite #{f.dest} with symlink? [ynq] "
      case $stdin.gets.chomp
      when 'y'
        link_file(f)
      when 'q'
        exit 1
      else
        puts "skipping #{f.dest}"
      end
    end

  else
    puts "create symlink #{f.dest}"
    link_file(f)
  end
end

def link_file(f)
  f.dest.delete if f.dest.exist?
  f.dest.make_symlink(f.src.realpath)
end

def install_file(f, opts={})
  icontent = file_content(f.src, opts)

  if f.dest.exist?
    ocontent = file_content(f.dest)

    if icontent == ocontent
      puts "identical #{f.dest}"

    else
        print "overwrite #{f.dest}? [ynq] "
        case $stdin.gets.chomp
        when 'y'
          save_file(f.dest, icontent)
        when 'q'
          exit 1
        else
          puts "skipping #{f.dest}"
        end
    end
  else
    puts "create #{f.dest}"
    save_file(f.dest, icontent)
  end
end

def file_content(file, opts={})
  content = IO.read(file)

  if opts[:erb]
    ERB.new(content).result(binding)
  else
    content
  end
end

def save_file(file, content)
  File.open(file, 'w') do |f|
    f.write content
  end
end

def path_tool( cmd )
  f = Tempfile.new( 'path_tool' )

  system("which #{cmd} >>#{f.path} 2>&1")
  return nil unless $?.exitstatus == 0

  path = IO.read(f.path).strip

  f.close
  f.unlink

  return path
end
