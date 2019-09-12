require "yaml"
require "singleton"
require "hashie"
require "erb"

module MyApp
  def self.reset
    Config.reset
  end

  def self.config
    Config.instance
  end

  class Config
    include Singleton

    class << self
      def reset
        @singleton__instance__ = nil
      end
    end

    attr_reader :env, :config

    def initialize
      if Dir["./*.erb*"] 
        yml = YAML.load(ERB.new(File.read("config.yml.erb")).result()) 
      else
        yml = YAML.load_file("config.yml")
      end
        @env = ENV.fetch("MY_APP_ENV", :development)
        @config = Hashie::Mash.new(yml["#{@env}"])
    end

    def method_missing(name, *args, &block)
      @config[name]
    end
  end
end
