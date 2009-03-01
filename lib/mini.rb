%w{ rubygems eventmachine activesupport ostruct json sinatra }.each { |lib| require lib }
%w{ listener irc web bot }.each { |lib| require File.dirname(__FILE__) + "/mini/#{ lib }" }