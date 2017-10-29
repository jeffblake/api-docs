# Unique header generation
require 'middleman-core/renderers/redcarpet'
# class UniqueHeadCounter < Middleman::Renderers::MiddlemanRedcarpetHTML
#   def initialize
#     super
#     @head_count = {}
#   end
#   def header(text, header_level)
#     friendly_text = text.parameterize
#     @head_count[friendly_text] ||= 0
#     @head_count[friendly_text] += 1
#     if @head_count[friendly_text] > 1
#       friendly_text += "-#{@head_count[friendly_text]}"
#     end
#     return "<h#{header_level} id='#{friendly_text}'>#{text}</h#{header_level}>"
#   end
# end

#TODO: https://github.com/lord/slate/issues/793
class UniqueHeadCounter < Middleman::Renderers::MiddlemanRedcarpetHTML
  def initialize
    super
    @head_count = {}
    @main_header = nil
  end
  def header(text, header_level)
    friendly_text = text.parameterize

    # Set the main header based on the header level 1
    @main_header = friendly_text if header_level == 1
    friendly_text = "#{@main_header}_#{text.parameterize}" if @main_header

    @head_count[friendly_text] ||= 0
    @head_count[friendly_text] += 1
    if @head_count[friendly_text] > 1
      friendly_text += "-#{@head_count[friendly_text]}"
    end
    return "<h#{header_level} id='#{friendly_text}'>#{text}</h#{header_level}>"
  end
end
