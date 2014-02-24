#!/usr/bin/env ruby
$app_path = File.expand_path(File.dirname((FileTest.symlink?(__FILE__)) ? File.readlink(__FILE__) : __FILE__))
require 'getoptlong'

#init section
$endprog	=	false	#used for interactive side of this program.
$version	=	"0.0.1" #helps me keep track more than anything else...
$config		=	"#{$app_path}/roxbury.cfg"

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
			exit(error_code)
		when 1
			puts	"Some other made up error that I might want to use more than once..."
	end
end	


begin
	print_usage(0)
rescue
	print_usage(1)
end
