#
# makedirs.rb
#


module Puppet::Parser::Functions
  newfunction(:makedirs, :type => :rvalue, :doc => <<-EOS
Returns a list of merged directories
*Examples:*

    makedirs('/tmp/somedir','a/deeper/dir')

Would return:

    ['/tmp/somedir','/tmp/somedir/a', '/tmp/somedir/a/deeper', ... aso.. ]
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "makedirs(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size != 2

    basepath = arguments[0]
    mergepath = arguments[1]
    lastpath = nil
    paths = Array.new

    mergepath.split('/').each do |mpath|
      if lastpath.nil?
          lastpath = basepath
      end

      if mpath.empty?
          next
      end
      paths.push lastpath
      lastpath = File.join(lastpath, mpath)
    end
    paths
  end
end

# vim: set ts=2 sw=2 et :
