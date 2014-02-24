#!/usr/bin/env ruby
$app_path = File.expand_path(File.dirname((FileTest.symlink?(__FILE__)) ? File.readlink(__FILE__) : __FILE__))
require 'getoptlong'

#init section
$endprog	= false	#used for interactive side of this program.
$version	= "0.0.1" #helps me keep track more than anything else...
$config		= "#{$app_path}/roxbury.cfg"
$c1		= "\033[0m" #Main
$c2		= "\033[0;35m" #Prompt
$c3		= "\033[0;31m" #Accient
$head		= "#{$c3}~#{$c1}"

def print_usage(error_code)
	case error_code
		when 0
			print	"Usage: ./roxbury.rb [options]\n\n"
			puts	"-h, --help				This help screen"
			puts	"-f, --fullurl user:pass@server:port	Full Username:Password@Pool.Server.Com:PORT\#"
			puts	"-s, --server pool.url.com:port		Pool Server URL:PORT"
			puts	"-l, --listen portnumber			Listening port number for incoming connections"
			puts	"-u, --username username			Pool Username"
			puts 	"-p, --password password			User password."
			print	"-v, --version				Display version information\n\n"
	
			puts	"Example: ./roxbury.rb -s stratum+tcp://btc.someserver.org:3333 -l 8330 -u \"SomeGuy.Slave1\" -p \"MadeUPpasSWOrD\""
		when 1
			puts "Some other made up error that I might want to use more than once..."

		when 9
			puts " #{$head}[ Roxbury - Stratum Bitcoin Mining Proxy ]#{$head} "
			puts " Author	:	deado"
			puts " Version :	#{$version}"
			puts " Email	: imdeado@gmail.com"
			puts " IRC	: irc.freenode.net/#gentoo.et"
	end
end

opts = GetoptLong.new(
	[ "--help",	"-h",	GetoptLong::NO_ARGUMENT ],
	[ "--fullurl",	"-f",	GetoptLong::REQUIRED_ARGUMENT ],
	[ "--server",	"-s",	GetoptLong::REQUIRED_ARGUMENT ],
	[ "--listen",	"-l",	GetoptLong::REQUIRED_ARGUMENT ],
	[ "--username",	"-u",	GetoptLong::REQUIRED_ARGUMENT ],
	[ "--password", "-p",	GetoptLong::REQUIRED_ARGUMENT ],
	[ "--version",	"-v",	GetoptLong::NO_ARGUMENT ],
	[ "--daemon",	"-d",	GetoptLong::NO_ARGUMENT ]
)

def parse_cmd(cmd, value)
	puts "cmd: #{cmd} && value: #{value}"
	case cmd
		when "fullurl"
			puts "You provided the following information... testing our pool connection:"
			puts "#{value}"
		when "server"
			puts "this is your server: #{value}"
		when "listen"
			puts "we are going to listen on port: #{value}"
		when "username"
			puts "Ok, I will connect using the following username: #{value}"
		when "password"
			puts "Sure thing... using password: #{value}"
		when "version"
			print_usage(9)
		when "help"
			print_usage(0)
		when "exit"
			$endprog = true
	end
end

begin
	opts.each do |opt, arg|
		case opt
			when "--help"
				print_usage(0)
			when "--fullurl"
				puts "This will call the function for entering full url as one (1) argument"
				parse_cmd("fullurl", arg)
			when "--server"
				puts "Use this option to specify a pool server."
				parse_cmd("server", arg)
			when "--listen"
				puts "Specify port to listen for traffic that we can send to our pool"
				parse_cmd("listen", arg)
			when "--username"
				puts "Username for your bitcoin mining pool!"
				parse_cmd("username", arg)
			when "--password"
				puts "Password for your mining worker on your bitcoin mining pool."
				parse_cmd("password", arg)
			when "--version"
				print_usage(9)
			when "--daemon"
				puts "Eventually, you will be able to run me as a daemon instead of normal program"
		else
			print_usage(0)
		end
	end
	
#	while !$endprog
#		begin
#			print "#{c2}$#{c1}"
#			parse_cmd(gets.strip.downcase)
#		rescue
#			$stderr.print "IO failed: " + $_ + "\n"
#		end
#	end
	print_usage(1) if opts == nil
rescue
	$stderr.print "IO FAILED: #{$!} \n"
	print_usage(1)
end
