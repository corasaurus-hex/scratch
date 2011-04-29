#!/usr/bin/env ruby
# Put somewhere in your path
# scratch       opens your most recent scratch file
# scratch -l    returns the filename of your latest scratch file (think ruby `scratch -l`
# scratch -n    starts a new scratch file
# scratch -a    opens entire scratch directory in your editor

class Scratch

  def self.itch
    new.itch
  end

  def itch
    if ARGV.last == "-n"
      edit(new_filename)
    elsif ARGV.last == "-a"
      edit_scratch_home
    elsif ARGV.last == "-l"
      print "#{scratch_home}/#{last_scratch_file}"
    elsif last_scratch_file
      edit(last_scratch_file)
    else
      edit(new_filename)
    end
  end

  def scratch_home
    @scratch_home ||= "#{ENV['HOME']}/.scratch"
  end

  def now
    @now ||= Time.now
  end

  def editor
    @editor ||= ENV['EDITOR'] || "mate"
  end

  def new_filename
    @new_filename ||= "#{now.strftime("%Y.%m.%d-%H:%M:%S.#{now.usec.to_s.rjust(6, "0")}")}.rb"
  end

  def last_scratch_file
    if @last_scratch_file
      @last_scratch_file
    else
      create_scratch_home
      @last_scratch_file = `ls #{scratch_home}`.split("\n").last
    end
  end

  def create_scratch_home
    `mkdir -p #{scratch_home}`
  end

  def initialize_file(file)
    create_scratch_home

    if !File.exists?("#{scratch_home}/#{file}")
      `touch #{scratch_home}/#{file}`
      `echo "#!/usr/bin/env ruby\n# Created: #{now}" > #{scratch_home}/#{file}`
    end
  end

  def edit_scratch_home
    edit(nil)
  end

  def edit(file)
    initialize_file(file)

    fork { `#{editor} #{scratch_home}/#{file}` }
  end

end

Scratch.itch
