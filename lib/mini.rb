%w{ rubygems eventmachine activesupport ostruct sinatra }.each { |lib| require lib }
%w{ listener irc web bot }.each { |lib| require File.dirname(__FILE__) + "/mini/#{ lib }" }