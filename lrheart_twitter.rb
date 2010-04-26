#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'oauth'
require 'json'
require 'hpricot'
require 'open-uri'
require 'yaml'
require 'parsedate'
require "kconv"
require File.dirname(__FILE__) + '/twitter_oauth'

# Usage:
# 1. このファイルと同じディレクトリに以下３つのファイルを設置します。
# * twitter_oauth.rb
# * http://github.com/japanrock/TwitterTools/blob/master/twitter_oauth.rb
# * sercret_key.yml
# * http://github.com/japanrock/TwitterTools/blob/master/secret_keys.yml.example
# * lrheart.yml
# * http://github.com/japanrock/TwitterLR_HEART/blob/master/lrheart.yml 
# 2. このファイルを実行します。
# ruby lrhert_twitter.rb

class LrHeart
  attr_reader :selected_culture
  attr_reader :select

  def initialize
    @culture = YAML.load_file(File.dirname(__FILE__) +  '/lrhert.yml')
  end

  def head
    ""
  end

  def random_select
    @selected_culture = @culture[select]
  end

  # ポストする範囲を指定する
  def select
    @select = rand(84)
  end
end

twitter_oauth = TwitterOauth.new
lrhert        = LrHeart.new

content  = lrhert.random_select
head     = lrhert.head
url      = lrhert.selected_culture["url"]
contents = lrhert.selected_culture["contents"]

twitter_oauth.post(head + contents + " - " + url)
