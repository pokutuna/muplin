require "muplin/version"
require 'rubygems'
require 'prawn'

class Muplin

  def self.exec(src_file, outline, dest_file = 'muplined.pdf')
    doc = self.new(src_file)
    doc.clear_outlines
    raise ArgumentError 'invalid outline' unless doc.instance_eval { sections? outline }
    doc.define_outline(outline)
    doc.render_file(dest_file)
  end

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
        puts "add section #{item.inspect}, #{parent.inspect}"
        add_section(item, parent)
        @last_label = item['label']
      elsif sections?(item)
        puts "subsections #{item.inspect}, #{parent.inspect}"
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
