LINE_HEIGHT = 30
MARGIN = 5

class Line
  # Where we store the appropriate text
  attr_accessor :text

  class << self
    # Set or get priority
    # Higher priority lines are matched first
    def priority p=nil
      if p
        @priority = p
      else
        @priority
      end
    end

    # These are our possible priorities
    def priorities
      @priorities ||= [:highest, :high, :normal, :low, :lowest]
    end

    # This is how subclasses determine priority
    def numeric_priority
      priorities.index(priority) || 10
    end
  end

  # Where we store subclasses
  @subclasses = []

  # Called when we make a new subclass - want to keep a register
  # of subbed classes
  def self.inherited(klass)
    @subclasses << klass
    @subclasses.sort_by(&:numeric_priority)
    puts "#{@subclasses.size} scs, sorted are #{@subclasses.inspect}"
  end

  # Run a line, work out best child, initialise it with line
  def self.process line
    k = @subclasses.find{ |sc| sc.pattern =~ line }
    if k
      k.new(line)
    else
      nil
    end
  end

  # Allows us to set or get a matching pattern
  def self.pattern v=nil
    if v
      @pattern = v
    else
      @pattern
    end
  end

  # Block to be called on rendering
  def self.on_render &blck
    if blck
      @on_render = blck
    else
      @on_render
    end
  end

  def initialize(text)
    @text = text
  end

  def pattern
    self.class.pattern
  end

  def on_render
    self.class.on_render
  end

  def render(doc)
    match = pattern.match(@text)
    on_render[doc, match]
  end

  def self.set_font_size(doc,size)
    doc.font_size size
    (LINE_HEIGHT - size)/2
  end
end

Dir[File.join(LIB_ROOT, "lib/lines/*.rb")].each{ |f| require f }