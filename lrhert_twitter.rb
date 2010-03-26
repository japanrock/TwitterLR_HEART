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

### TODO:
###  ・TwitterBaseクラスはあとで外に出す

# Usage:
# ruby lrhert_twitter.rb /path/to/sercret_key.yml /path/to/lrhert.yml


# TwitterのAPIとのやりとりを行うクラス
class TwitterBase
  def initialize
    # config.yml内のsercret_keys.ymlをloadします。
    @secret_keys = YAML.load_file(ARGV[0] || 'sercret_key.yml')
  end
  
  def consumer_key
    @secret_keys["ConsumerKey"]
  end

  def consumer_secret
    @secret_keys["ConsumerSecret"]
  end

  def access_token_key
    @secret_keys["AccessToken"]
  end

  def access_token_secret
    @secret_keys["AccessTokenSecret"]
  end

  def consumer
    @consumer = OAuth::Consumer.new(
      consumer_key,
      consumer_secret,
      :site => 'http://twitter.com'
    )
  end

  def access_token
    consumer
    access_token = OAuth::AccessToken.new(
      @consumer,
      access_token_key,
      access_token_secret
    )
  end

  def post(tweet=nil)
    response = access_token.post(
      'http://twitter.com/statuses/update.json',
      'status'=> tweet
    )
  end
end

class LrHeart
  attr_reader :selected_culture
  attr_reader :select

  def initialize
    @culture = YAML.load_file(ARGV[1] || 'lrhert.yml')
  end

  # ここはあとでリファクタリング・・・微妙なので・・・
  def head
    "[lrheart]"
  end

  def random_select
    @selected_culture = @culture[select]
  end

  # ポストする範囲を指定する
  def select
    @select = rand(56)
  end
end

twitter_base = TwitterBase.new
lrhert       = LrHeart.new

content  = lrhert.random_select
head     = lrhert.head
url      = lrhert.selected_culture["url"]
contents = lrhert.selected_culture["contents"]

twitter_base.post(head + contents + " - " + url)
