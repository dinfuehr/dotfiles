require 'rake'
require 'erb'
require 'fileutils'

desc "install the dot files into user's home directory"
task :install do
  # check requirements, git and zsh
  check_requirements

  # Install oh my zsh
  install_oh_my_zsh

  # switch to zsh
  switch_to_zsh

  # link sublime user-directory
  link_sublime_user

  files = [
    [ 'zshrc', '~/.zshrc', { :link => false } ],
    [ 'gitconfig.erb', '~/.gitconfig' ],
    [ 'gitignore', '~/.gitignore' ],
    [ 'ackrc', '~/.ackrc' ],
    [ 'irbrc', '~/.irbrc' ],
    [ 'hgrc', '~/.hgrc' ],
    [ 'dinfuehr.plugin.zsh', "~/.oh-my-zsh/custom/plugins/dinfuehr/dinfuehr.plugin.zsh" ]
  ]

  files.each do |f|
    opts = f[ 2 ] || {}

    ifile = File.new( f[ 0 ] )
    ofile = file_name( f[ 1 ] )

    if opts[ :link ] == false || ifile.path.end_with?( '.erb' )
      install_file( ifile, ofile )
    else
      install_link_file( ifile, ofile )
    end
  end
end

def check_requirements
  check_installed 'zsh'
  check_installed 'git'
end

def check_installed( tool )
  p = path_tool tool

  if p == nil
    puts "#{tool} not installed"
    exit 1
  end
end

def install_link_file( ifile, ofile, opts={} )
  ifile = File.new( ifile )

  if File.exists?( ofile )
    path = File.readlink( ofile ) if File.symlink?( ofile )

    if File.absolute_path( ifile ) == path
      puts "identical symlink #{ofile}"

    else
      print "overwrite #{ofile} with symlink? [ynq] "
      case $stdin.gets.chomp
      when 'y'
        link_file( ifile, ofile )
      when 'q'
        exit 1
      else
        puts "skipping #{ofile}"
      end
    end

  else
    puts "create symlink #{ofile}"
    link_file( ifile, ofile )
  end
end

def link_file( ifile, ofile )
  begin
    File.delete( ofile )
  rescue => e

  end

  File.symlink( File.absolute_path( ifile ), ofile )
end

def install_file( ifile, ofile, opts={} )
  icontent = file_content( ifile )

  if File.exists?( ofile )
    ofile = File.new( ofile )
    ocontent = file_content( ofile )

    if icontent == ocontent
      puts "identical #{ofile.path}"

    else
        print "overwrite #{ofile.path}? [ynq] "
        case $stdin.gets.chomp
        when 'y'
          save_file( ofile, icontent )
        when 'q'
          exit 1
        else
          puts "skipping #{ofile.path}"
        end

    end

  else
    puts "create #{ofile}"
    save_file( ofile, icontent )
  end
end

def file_content( file )
  content = IO.read( file )

  if file.path.end_with?( '.erb' )
    ERB.new( content ).result( binding )
  else
    content
  end
end

def path_tool( cmd )
  path = `which #{cmd}`.strip
  return nil unless $?.exitstatus == 0

  path
end

def save_file( file, content )
  File.open( file, 'w' ) do |f|
    f.write content
  end
end

def file_name( file )
  file.gsub( '~', ENV[ 'HOME' ] )
end

def switch_to_zsh
  if ENV[ 'SHELL' ] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit 1
    else
      puts "skipping zsh"
    end
  end
end

def link_sublime_user
  if linux?
    src = "#{ENV[ 'HOME' ]}/.config/sublime-text-3/Packages/User"
  else
    src = "#{ENV[ 'HOME' ]}/Library/Application Support/Sublime Text 3/Packages/User"
  end

  dest = "#{ENV[ 'HOME' ]}/Dropbox/sublime-user"
  cmd = %Q{ln -s "#{dest}" "#{src}"}

  unless File.directory?( dest )
    puts "missing #{dest}, install dropbox"
    return
  end

  if File.exists?( src )
    if File.identical? src, dest
      puts "identical #{dest}"
    else
      print "link #{src} to #{dest}? [ynaq] "
      case $stdin.gets.chomp
      when 'y'
        system "rm -rf #{src}"
        system cmd
      when 'q'
        exit 1
      else
        puts "skipping #{src}"
      end
    end
  else
    puts "sublime not installed, can not link user directory"
  end
end

def linux?
  `uname`.strip == 'Linux'
end

def mac?
  `uname`.strip == 'Darwin'
end

def install_oh_my_zsh
  if File.directory?( file_name( '~/.oh-my-zsh' ) )
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit 1
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end
