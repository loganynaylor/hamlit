require 'temple/html/filter'
require 'hamlit/concerns/registerable'
require 'hamlit/filters/javascript'

module Hamlit
  class FilterCompiler < Temple::HTML::Filter
    extend Concerns::Registerable

    register :javascript, Filters::Javascript

    def on_haml_filter(name, exp)
      compiler = FilterCompiler.find(name)
      compiler.compile(exp)
    end
  end
end
