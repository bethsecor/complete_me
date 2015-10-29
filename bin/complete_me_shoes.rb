require '../lib/complete_me'

Shoes.app do
  completion = CompleteMe.new
  dictionary = File.read("/usr/share/dict/words")
  completion.populate(dictionary)

  background rgb(204, 255, 204)
  stack(margin: 10) do
    @banner = banner "AUTOCOMPLETE"
    @banner.style size: 28, stroke: rgb(0, 102, 102), font: "Adele"

    @para = para strong("Begin to enter a word:")
    @para.style font: "Avenir"
    flow do
      @edit = edit_line width: 250
      @edit.style size: 14
      @push_me = button "Select"
      # @push_me.style font: "Avenir"
      @push_me.click do
        unless @edit.text.empty?
          completion.select("", @edit.text)
        end
      end
      stack do
        @shoes_suggests = para ""
        @shoes_suggests.style font: "Avenir"
        @edit.change do
          if @edit.text.empty?
            @shoes_suggests.replace ""
          else
            @shoes_suggests.replace completion.suggest(@edit.text).join(', ')
          end
        end
      end
    end
  end
end
