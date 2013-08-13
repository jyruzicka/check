class DoneItemLine < Line
  pattern /^[*-]\s+(.+)\s+@done\s*$/
  priority :normal

  on_render do |doc,m|
    top_margin = set_font_size(doc,14)

    doc.bounding_box([doc.bounds.left,doc.cursor], width:doc.bounds.width, height:LINE_HEIGHT) do
      doc.stroke_bounds
      doc.stroke_rectangle [doc.bounds.left, doc.bounds.top], LINE_HEIGHT, LINE_HEIGHT

      #Cross it!
      cross_left = doc.bounds.left + 5
      cross_right = doc.bounds.left + LINE_HEIGHT - 5
      cross_top = doc.bounds.top - 5
      cross_bottom = doc.bounds.top - LINE_HEIGHT + 5
      doc.line [cross_left, cross_top], [cross_right, cross_bottom]
      doc.line [cross_left, cross_bottom], [cross_right, cross_top]

      doc.translate(LINE_HEIGHT+MARGIN, -top_margin) do
        doc.text m[1]
      end
    end
  end
end
