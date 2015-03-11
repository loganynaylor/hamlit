describe Hamilton::Engine do
  describe 'silent script' do
    it 'parses silent script' do
      assert_render(<<-HAML, <<-HTML)
        - foo = 3
        - bar = 2
        = foo + bar
      HAML
        5
      HTML
    end

    it 'parses nested block' do
      assert_render(<<-HAML, <<-HTML)
        - 2.times do |i|
          = i
        2
        - 3.upto(4).each do |i|
          = i
      HAML
        0
        1
        2
        3
        4
      HTML
    end

    it 'parses if' do
      assert_render(<<-HAML, <<-HTML)
        - if true
          ok
      HAML
        ok
      HTML
    end
  end
end
