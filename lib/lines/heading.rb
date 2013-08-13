class HeadingLine < Line

  priority :lowest

  pattern /^(.+):$/
  
  on_render do |doc, m|
    top_margin = set_font_size(doc,20)

    doc.bounding_box([doc.bounds.left,doc.cursor], width:doc.bounds.width, height:LINE_HEIGHT) do
      doc.stroke_bounds
      doc.translate(MARGIN,-top_margin) do
        doc.text m[1]
      end
    end
  end
end