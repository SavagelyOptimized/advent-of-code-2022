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
    @children = []
    @files = []
  end

  def size
    @children.map(&:size).sum + @files.map(&:size).sum
  end
end

root = Directory.new '/', nil
pwd = [root]
all_dirs = [root]

ARGF.each_line do |line|
  if /cd ([[:alpha:]])+/ =~ line
    dir_name = $~.captures[0]
    dir = Directory.new(dir_name, pwd.last)
    pwd.last.children.push dir
    pwd.push dir
    all_dirs.push dir
  elsif /cd \.\./ =~ line
    pwd.pop
  elsif /(\d+) ([[:alpha:]]+\.?[[:alpha:]]*)/ =~ line
    dir = pwd.last
    dir.files.push File.new($~.captures[1], Integer($~.captures[0]))
  end
end

p all_dirs.select { |d| d.size < 100000 }.map(&:size).sum

unused = 70000000 - root.size
needed = 30000000 - unused
p all_dirs.sort_by { |d| d.size }.find { |d| d.size > needed }.size
