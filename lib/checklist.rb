class Checklist
  attr_accessor :lines

  def initialize(file)
    @lines = []
    contents = File.read(file)
    contents.each_line do |l|
      new_line = Line.process(l) 
      @lines << new_line if new_line
    end
  end

  def each &blck
    @lines.each(&blck)
  end
end

