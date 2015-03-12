require 'hamlit'
require 'unindent'

module HamlitSpecHelper
  def parse_string(str)
    Hamlit::Parser.new.call(str)
  end

  def render_string(str)
    eval Hamlit::Engine.new.call(str)
  end

  def assert_render(haml, html)
    haml = haml.unindent
    html = html.unindent

    expect(render_string(haml)).to eq(html)
  end

  def assert_parse(haml, &block)
    haml = haml.unindent
    ast  = block.call

    expect(parse_string(haml)).to eq(ast)
  end
end

RSpec.configure do |config|
  config.include HamlitSpecHelper

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
