require 'prawn'
require "muplin/version"
require 'muplin/outliner'

module Muplin

  def self.exec(src_file, outline, dest_file = 'muplined.pdf')
    doc = Muplin::Outliner.new(src_file)
    doc.clear_outlines
    raise ArgumentError 'invalid outline' unless doc.instance_eval { sections? outline }
    doc.define_outline(outline)
    doc.render_file(dest_file)
  end

end
