class File
  attr_accessor :name
  attr_accessor :size

  def initialize(name, size)
    @name = name
    @size = size
  end
end

class Directory
  attr_accessor :name
  attr_accessor :children
  attr_accessor :files

  def initialize(name, parent)
    @name = name
    @parent = parent
    @children = {}
    @files = {}
  end

  def size
    @children.values.map(&:size).sum + @files.values.map(&:size).sum
  end
end

pwd = []
root = Directory.new '/', nil
all_dirs = []

ARGF.each_line do |line|
  p line

  if /cd ([[:alpha:]])+/ =~ line
    dir_name = $~.captures[0]
    dir = Directory.new(dir_name, pwd.last)
    pwd.last.children[dir_name] = dir
    pwd.push dir
    all_dirs.push dir
  elsif /cd \// =~ line
    pwd = [root]
  elsif /cd \.\./ =~ line
    pwd.pop
  elsif /(\d+) ([[:alpha:]]+\.?[[:alpha:]]*)/ =~ line
    dir = pwd.last
    dir.files[$~.captures[1]] = File.new($~.captures[1], Integer($~.captures[0]))
  end
end

p all_dirs.select { |d| d.size < 100000 }.map(&:size).sum
