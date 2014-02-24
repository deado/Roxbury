#!/usr/bin/env ruby
$app_path = File.expand_path(File.dirname((FileTest.symlink?(__FILE__)) ? File.readlink(__FILE__) : __FILE__))
require 'getoptlong'

#init section
$endprog	=	false	#used for interactive side of this program.
$version	=	"0.0.1" #helps me keep track more than anything else...
$config		=	"#{$app_path}/roxbury.cfg"

