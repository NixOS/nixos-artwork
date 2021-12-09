#!/usr/bin/env ruby

require "nokogiri"
require "fileutils"

$document = ARGV.first
$out = ENV["out"]

include FileUtils

def save(doc, out)
  File.open("icons.src.svg", "w") do |f|
    doc.write_xml_to(f, :encoding => "UTF-8")
  end

  system(
    "inkscape",
    "icons.src.svg",
    "--export-area-page",
    "--export-filename=#{out}",
  )

  rm("icons.src.svg")
end

puts("Matrix Icons Builder...")
puts("=======================\n")

mkdir_p($out)
$doc = Nokogiri::XML::Document.parse(File.read($document))

$doc.element_children.each do |svg|
  # Checks we indeed loaded an SVG document...
  raise unless svg.name == "svg"

  # First hide everything.
  svg.element_children.select {|el| el.name == "g"}.each do |el|
    el["style"] = "display:none"
  end

  # Then prepare exports for this category
  svg.element_children.select {|el| el.name == "g"}.each do |el|
    type = el["inkscape:label"]

    # Skip an unneeded category
    next if type == "DO NOT PRINT"

    # Show the current layer
    el["style"] = ""

    # But first hide everything but the background
    el.element_children.each do |child|
      if child["inkscape:label"].match(/^\$BACKGROUND/)
        child["style"] = ""
      else
        child["style"] = "display:none"
      end
    end

    el.element_children.each do |child|
      next if child["inkscape:label"].match(/^\$BACKGROUND/)
      # Show the layer
      child["style"] = ""

      name = child["inkscape:label"]
      save($doc, File.join($out, "#{type}-#{name}.png"))

      # Hide the layer
      child["style"] = "display:none"
    end

    # Hide the current layer again
    el["style"] = "display:none"
  end
end
