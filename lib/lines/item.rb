class ItemLine < Line
  pattern /^[*-]\s+(.+)$/
  priority :lowest

  on_render do |doc,m|
    top_margin = set_font_size(doc,14)

    doc.bounding_box([doc.bounds.left,doc.cursor], width:doc.bounds.width, height:LINE_HEIGHT) do
      doc.stroke_bounds
      doc.stroke_rectangle [doc.bounds.left, doc.bounds.top], LINE_HEIGHT, LINE_HEIGHT
      doc.translate(LINE_HEIGHT+MARGIN, -top_margin) do
        doc.text m[1]
      end
    end
  end
end
