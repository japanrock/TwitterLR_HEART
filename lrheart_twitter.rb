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
require File.dirname(__FILE__) + '/shorten_url'

# Usage:
#  1. このファイルと同じディレクトリに以下5つのファイルを設置します。
#   * twitter_oauth.rb
#    * http://github.com/japanrock/TwitterTools/blob/master/twitter_oauth.rb
#   * sercret_key.yml
#    * http://github.com/japanrock/TwitterTools/blob/master/secret_keys.yml.example
#   * lrheart.yml
#    * http://github.com/japanrock/TwitterLR_HEART/blob/master/lrheart.yml 
#   * shorten_url.rb
#    * http://github.com/japanrock/TwitterTools/blob/master/shorten_url.rb
#   * bit_ly_api_key.yml
#    * http://github.com/japanrock/TwitterTools/blob/master/bit_ly_api_key.yml
#  2. このファイルを実行します。
#   ruby lrheart_twitter.rb

class LrHeart
  attr_reader :selected_culture
  attr_reader :select

  def initialize
    @culture = YAML.load_file(File.dirname(__FILE__) +  '/lrheart.yml')
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
shorten_url   = ShortenURL.new

content  = lrhert.random_select
head     = lrhert.head
url      = lrhert.selected_culture["url"]
contents = lrhert.selected_culture["contents"]

# URL短縮
shorten_url.get_short_url(url)
short_url = shorten_url.short_url

twitter_oauth.post(head + contents + " - " + short_url)
