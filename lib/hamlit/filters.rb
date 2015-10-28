require 'hamlit/filters/base'
require 'hamlit/filters/tilt_base'
require 'hamlit/filters/coffee'
require 'hamlit/filters/css'
require 'hamlit/filters/erb'
require 'hamlit/filters/escaped'
require 'hamlit/filters/javascript'
require 'hamlit/filters/less'
require 'hamlit/filters/markdown'
require 'hamlit/filters/plain'
require 'hamlit/filters/preserve'
require 'hamlit/filters/ruby'
require 'hamlit/filters/scss'

module Hamlit
  class Filters
    @registered = {}

    class << self
      attr_reader :registered

      private

      def register(name, compiler)
        registered[name] = compiler
      end
    end

    register :coffee,       Coffee
    register :coffeescript, Coffee
    register :css,          Css
    register :erb,          Erb
    register :escaped,      Escaped
    register :javascript,   Javascript
    register :less,         Less
    register :markdown,     Markdown
    register :plain,        Plain
    register :preserve,     Preserve
    register :ruby,         Ruby
    register :scss,         Scss

    def initialize(options = {})
      @options = options
      @compilers = {}
    end

    def compile(node)
      find_compiler(node.value[:name]).compile(node)
    end

    private

    def find_compiler(name)
      name = name.to_sym
      compiler = Filters.registered[name]
      raise NotFound.new("FilterCompiler for '#{name}' was not found") unless compiler

      @compilers[name] ||= compiler.new(@options)
    end

    class NotFound < RuntimeError
    end
  end
end
