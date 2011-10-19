class Muplin::Outliner

  def initialize(filename)
    @pdf = Prawn::Document.new(:template => filename)
  end


  public
  def clear_outlines
    @pdf.state.store.root.data[:Outlines] = nil
  end

  def define_outline(outlines, parent = nil)
    outlines.each do |item|
      if a_section?(item)
        add_section(item, parent)
        @last_label = item['label']
      elsif sections?(item)
        define_outline(item, @last_label)
      else
        raise ArgumentError
      end
    end
  end

  def render_file(filename)
    @pdf.render_file(filename)
  end


  private
  def a_section?(item)
    Hash === item and item.has_key?('label') and item.has_key?('page')
  end

  def sections?(item)
    Array === item
  end

  def add_section(section, parent)
    if parent.nil?
      @pdf.outline.section section['label'], :destination => section['page']
    else
      @pdf.outline.add_subsection_to(parent) {
        @pdf.outline.page :title => section['label'], :destination => section['page']
      }
    end
  end

end
