#!/usr/bin/env ruby

TestDir = File.dirname(File.expand_path(__FILE__))
SourceTree = File.expand_path(File.join(TestDir, '..'))
LibDir = File.join(SourceTree, 'lib')

$: << File.join(SourceTree, 'lib')

%w(
	test/unit
	rubygems
	hoshi
).each &method(:require)

Dir[File.join(TestDir, '*_test.rb')].each &method(:require)
