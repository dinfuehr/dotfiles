require 'rake'
require 'erb'
require 'fileutils'

desc "install the dot files into user's home directory"
task :install do
  # Install oh my zsh
  install_oh_my_zsh

  # switch to zsh
  switch_to_zsh

  # link sublime user-directory
  link_sublime_user

  path = 'oh-my-zsh/custom/plugins/dinfuehr'

  files = [
    [ 'zshrc', '~/.zshrc' ],
    [ 'gitconfig.erb', '~/.gitconfig' ],
    [ 'gitignore', '~/.gitignore' ],
    [ 'ackrc', '~/.ackrc' ],
    [ 'irbrc', '~/.irbrc' ],
    [ "#{path}/dinfuehr.plugin.zsh", "~/.#{path}/dinfuehr.plugin.zsh" ]
  ]

  files.each do |f|
    install_file( f[ 0 ], f[ 1 ], f[ 2 ] || {} )
  end
end

def install_file( ifile, ofile, opts={} )
  icontent = file_content( ifile )

  if File.exists?( file_name( ofile ) )
    ocontent = file_content( ofile )

    if icontent == ocontent
      puts "identical #{ofile}"

    else
        print "overwrite #{ofile}? [ynq] "
        case $stdin.gets.chomp
        when 'y'
          save_file( ofile, icontent )
        when 'q'
          exit
        else
          puts "skipping #{ofile}"
        end

    end

  else
    puts "create #{ofile}"
    save_file( ofile, icontent )
  end
end

def file_content( file )
  content = IO.read( file_name( file ) )

  if file.end_with?( '.erb' )
    ERB.new( content ).result( binding )
  else
    content
  end
end

def save_file( file, content )
  File.open( file_name( file ), 'w' ) do |f|
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
      exit
    else
      puts "skipping zsh"
    end
  end
end

def link_sublime_user
  if linux?
    src = "#{ENV[ 'HOME' ]}/.config/sublime-text-2/Packages/User"
  else
    src = "#{ENV[ 'HOME' ]}/Library/Application Support/Sublime Text 2/Packages/User"
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
        exit
      else
        puts "skipping #{src}"
      end
    end
  else
    system cmd
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
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end
