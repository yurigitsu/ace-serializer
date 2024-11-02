# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `iniparse` gem.
# Please instead update this file by running `bin/tapioca gem iniparse`.


# source://iniparse//lib/iniparse/document.rb#1
module IniParse
  private

  # Creates a new IniParse::Document using the specification you provide.
  #
  # See IniParse::Generator.
  #
  # ==== Returns
  # IniParse::Document
  #
  # source://iniparse//lib/iniparse.rb#63
  def gen(&blk); end

  # Opens the file at +path+, reads and parses it's contents.
  #
  # ==== Parameters
  # path<String>:: The path to the INI document.
  #
  # ==== Returns
  # IniParse::Document
  #
  # source://iniparse//lib/iniparse.rb#50
  def open(path); end

  # Parse given given INI document source +source+.
  #
  # See IniParse::Parser.parse
  #
  # ==== Parameters
  # source<String>:: The source from the INI document.
  #
  # ==== Returns
  # IniParse::Document
  #
  # source://iniparse//lib/iniparse.rb#38
  def parse(source); end

  class << self
    # Creates a new IniParse::Document using the specification you provide.
    #
    # See IniParse::Generator.
    #
    # ==== Returns
    # IniParse::Document
    #
    # source://iniparse//lib/iniparse.rb#63
    def gen(&blk); end

    # Opens the file at +path+, reads and parses it's contents.
    #
    # ==== Parameters
    # path<String>:: The path to the INI document.
    #
    # ==== Returns
    # IniParse::Document
    #
    # source://iniparse//lib/iniparse.rb#50
    def open(path); end

    # Parse given given INI document source +source+.
    #
    # See IniParse::Parser.parse
    #
    # ==== Parameters
    # source<String>:: The source from the INI document.
    #
    # ==== Returns
    # IniParse::Document
    #
    # source://iniparse//lib/iniparse.rb#38
    def parse(source); end
  end
end

# Represents an INI document.
#
# source://iniparse//lib/iniparse/document.rb#3
class IniParse::Document
  include ::Enumerable

  # Creates a new Document instance.
  #
  # @return [Document] a new instance of Document
  #
  # source://iniparse//lib/iniparse/document.rb#10
  def initialize(path = T.unsafe(nil)); end

  # Returns the section identified by +key+.
  #
  # Returns nil if there is no Section with the given key.
  #
  # source://iniparse//lib/iniparse/document.rb#31
  def [](key); end

  # Deletes the section whose name matches the given +key+.
  #
  # Returns the document.
  #
  # source://iniparse//lib/iniparse/document.rb#47
  def delete(*args); end

  # Enumerates through each Section in this document.
  #
  # Does not yield blank and comment lines by default; if you want _all_
  # lines to be yielded, pass true.
  #
  # ==== Parameters
  # include_blank<Boolean>:: Include blank/comment lines?
  #
  # source://iniparse//lib/iniparse/document.rb#23
  def each(*args, &blk); end

  # Returns true if a section with the given +key+ exists in this document.
  #
  # @return [Boolean]
  #
  # source://iniparse//lib/iniparse/document.rb#87
  def has_section?(key); end

  # A human-readable version of the document, for debugging.
  #
  # source://iniparse//lib/iniparse/document.rb#81
  def inspect; end

  # Returns the value of attribute lines.
  #
  # source://iniparse//lib/iniparse/document.rb#6
  def lines; end

  # Returns the value of attribute path.
  #
  # source://iniparse//lib/iniparse/document.rb#7
  def path; end

  # Sets the attribute path
  #
  # @param value the value to set the attribute path to.
  #
  # source://iniparse//lib/iniparse/document.rb#7
  def path=(_arg0); end

  # Saves a copy of this Document to disk.
  #
  # If a path was supplied when the Document was initialized then nothing
  # needs to be given to Document#save. If Document was not given a file
  # path, or you wish to save the document elsewhere, supply a path when
  # calling Document#save.
  #
  # ==== Parameters
  # path<String>:: A path to which this document will be saved.
  #
  # ==== Raises
  # IniParseError:: If your document couldn't be saved.
  #
  # @raise [IniParseError]
  #
  # source://iniparse//lib/iniparse/document.rb#104
  def save(path = T.unsafe(nil)); end

  # Returns the section identified by +key+.
  #
  # If there is no Section with the given key it will be created.
  #
  # source://iniparse//lib/iniparse/document.rb#39
  def section(key); end

  # Returns a has representation of the INI with multi-line options
  # as an array
  #
  # source://iniparse//lib/iniparse/document.rb#64
  def to_h; end

  # Returns a has representation of the INI with multi-line options
  # as an array
  #
  # source://iniparse//lib/iniparse/document.rb#64
  def to_hash; end

  # Returns this document as a string suitable for saving to a file.
  #
  # source://iniparse//lib/iniparse/document.rb#53
  def to_ini; end

  # Returns this document as a string suitable for saving to a file.
  #
  # source://iniparse//lib/iniparse/document.rb#53
  def to_s; end
end

# Generator provides a means for easily creating new INI documents.
#
# Rather than trying to hack together new INI documents by manually creating
# Document, Section and Option instances, it is preferable to use Generator
# which will handle it all for you.
#
# The Generator is exposed through IniParse.gen.
#
#   IniParse.gen do |doc|
#     doc.section("vehicle") do |vehicle|
#       vehicle.option("road_side", "left")
#       vehicle.option("realistic_acceleration", true)
#       vehicle.option("max_trains", 500)
#     end
#
#     doc.section("construction") do |construction|
#       construction.option("build_on_slopes", true)
#       construction.option("autoslope", true)
#     end
#   end
#
#   # => IniParse::Document
#
# This can be simplified further if you don't mind the small overhead
# which comes with +method_missing+:
#
#   IniParse.gen do |doc|
#     doc.vehicle do |vehicle|
#       vehicle.road_side = "left"
#       vehicle.realistic_acceleration = true
#       vehicle.max_trains = 500
#     end
#
#     doc.construction do |construction|
#       construction.build_on_slopes = true
#       construction.autoslope = true
#     end
#   end
#
#   # => IniParse::Document
#
# If you want to add slightly more complicated formatting to your document,
# each line type (except blanks) takes a number of optional parameters:
#
# :comment::
#   Adds an inline comment at the end of the line.
# :comment_offset::
#   Indent the comment. Measured in characters from _beginning_ of the line.
#   See String#ljust.
# :indent::
#   Adds the supplied text to the beginning of the line.
#
# If you supply +:indent+, +:comment_sep+, or +:comment_offset+ options when
# adding a section, the same options will be inherited by all of the options
# which belong to it.
#
#   IniParse.gen do |doc|
#     doc.section("vehicle",
#       :comment => "Options for vehicles", :indent  => "    "
#     ) do |vehicle|
#       vehicle.option("road_side", "left")
#       vehicle.option("realistic_acceleration", true)
#       vehicle.option("max_trains", 500, :comment => "More = slower")
#     end
#   end.to_ini
#
#       [vehicle] ; Options for vehicles
#       road_side = left
#       realistic_acceleration = true
#       max_trains = 500 ; More = slower
#
# source://iniparse//lib/iniparse/generator.rb#73
class IniParse::Generator
  # @return [Generator] a new instance of Generator
  #
  # source://iniparse//lib/iniparse/generator.rb#77
  def initialize(opts = T.unsafe(nil)); end

  # Adds a new blank line to the document.
  #
  # source://iniparse//lib/iniparse/generator.rb#170
  def blank; end

  # Adds a new comment line to the document.
  #
  # ==== Parameters
  # comment<String>:: The text for the comment line.
  #
  # source://iniparse//lib/iniparse/generator.rb#163
  def comment(comment, opts = T.unsafe(nil)); end

  # Returns the value of attribute context.
  #
  # source://iniparse//lib/iniparse/generator.rb#74
  def context; end

  # Returns the value of attribute document.
  #
  # source://iniparse//lib/iniparse/generator.rb#75
  def document; end

  # @yield [_self]
  # @yieldparam _self [IniParse::Generator] the object that the method was called on
  #
  # source://iniparse//lib/iniparse/generator.rb#85
  def gen; end

  # source://iniparse//lib/iniparse/generator.rb#183
  def method_missing(name, *args, &blk); end

  # Adds a new option to the current section.
  #
  # Can only be called as part of a section block, or after at least one
  # section has been added to the document.
  #
  # ==== Parameters
  # key<String>:: The key (name) for this option.
  # value::       The option's value.
  # opts<Hash>::  Extra options for the line (formatting, etc).
  #
  # ==== Raises
  # IniParse::NoSectionError::
  #   If no section has been added to the document yet.
  #
  # source://iniparse//lib/iniparse/generator.rb#147
  def option(key, value, opts = T.unsafe(nil)); end

  # Creates a new section with the given name and adds it to the document.
  #
  # You can optionally supply a block (as detailed in the documentation for
  # Generator#gen) in order to add options to the section.
  #
  # ==== Parameters
  # name<String>:: A name for the given section.
  #
  # source://iniparse//lib/iniparse/generator.rb#107
  def section(name, opts = T.unsafe(nil)); end

  # Wraps lines, setting default options for each.
  #
  # @yield [_self]
  # @yieldparam _self [IniParse::Generator] the object that the method was called on
  #
  # source://iniparse//lib/iniparse/generator.rb#175
  def with_options(opts = T.unsafe(nil)); end

  private

  # Returns options for a line.
  #
  # If the context is a section, we use the section options as a base,
  # rather than the global defaults.
  #
  # source://iniparse//lib/iniparse/generator.rb#200
  def line_options(given_opts); end

  class << self
    # Creates a new IniParse::Document with the given sections and options.
    #
    # ==== Returns
    # IniParse::Document
    #
    # source://iniparse//lib/iniparse/generator.rb#95
    def gen(opts = T.unsafe(nil), &blk); end
  end
end

# A base class for IniParse errors.
#
# source://iniparse//lib/iniparse.rb#13
class IniParse::IniParseError < ::StandardError; end

# Represents a collection of lines in an INI document.
#
# LineCollection acts a bit like an Array/Hash hybrid, allowing arbitrary
# lines to be added to the collection, but also indexes the keys of Section
# and Option lines to enable O(1) lookup via LineCollection#[].
#
# The lines instances are stored in an array, +@lines+, while the index of
# each Section/Option is held in a Hash, +@indicies+, keyed with the
# Section/Option#key value (see LineCollection#[]=).
#
# source://iniparse//lib/iniparse/line_collection.rb#12
module IniParse::LineCollection
  include ::Enumerable

  # source://iniparse//lib/iniparse/line_collection.rb#15
  def initialize; end

  # Appends a line to the collection.
  #
  # Note that if you pass a line with a key already represented in the
  # collection, the old item will be replaced.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#46
  def <<(line); end

  # Retrive a value identified by +key+.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#21
  def [](key); end

  # Set a +value+ identified by +key+.
  #
  # If a value with the given key already exists, the value will be replaced
  # with the new one, with the new value taking the position of the old.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#30
  def []=(key, value); end

  # Removes the value identified by +key+.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#70
  def delete(key); end

  # Enumerates through the collection.
  #
  # By default #each does not yield blank and comment lines.
  #
  # ==== Parameters
  # include_blank<Boolean>:: Include blank/comment lines?
  #
  # source://iniparse//lib/iniparse/line_collection.rb#59
  def each(include_blank = T.unsafe(nil)); end

  # Returns whether +key+ is in the collection.
  #
  # @return [Boolean]
  #
  # source://iniparse//lib/iniparse/line_collection.rb#81
  def has_key?(*args); end

  # Return an array containing the keys for the lines added to this
  # collection.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#87
  def keys; end

  # Appends a line to the collection.
  #
  # Note that if you pass a line with a key already represented in the
  # collection, the old item will be replaced.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#46
  def push(line); end

  # Returns this collection as an array. Includes blank and comment lines.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#92
  def to_a; end

  # Returns this collection as a hash. Does not contain blank and comment
  # lines.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#98
  def to_h; end

  # Returns this collection as a hash. Does not contain blank and comment
  # lines.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#98
  def to_hash; end
end

# Raised when a line is added to a collection which isn't allowed (e.g.
# adding a Section line into an OptionCollection).
#
# source://iniparse//lib/iniparse.rb#24
class IniParse::LineNotAllowed < ::IniParse::IniParseError; end

# source://iniparse//lib/iniparse/lines.rb#2
module IniParse::Lines; end

# Stores options which appear at the beginning of a file, without a
# preceding section.
#
# source://iniparse//lib/iniparse/lines.rb#225
class IniParse::Lines::AnonymousSection < ::IniParse::Lines::Section
  # @return [AnonymousSection] a new instance of AnonymousSection
  #
  # source://iniparse//lib/iniparse/lines.rb#226
  def initialize; end

  # source://iniparse//lib/iniparse/lines.rb#230
  def to_ini; end

  private

  # source://iniparse//lib/iniparse/lines.rb#240
  def line_contents; end
end

# Represents a blank line. Used so that we can preserve blank lines when
# writing back to the file.
#
# source://iniparse//lib/iniparse/lines.rb#307
class IniParse::Lines::Blank
  include ::IniParse::Lines::Line

  # @return [Boolean]
  #
  # source://iniparse//lib/iniparse/lines.rb#310
  def blank?; end

  class << self
    # source://iniparse//lib/iniparse/lines.rb#314
    def parse(line, opts); end
  end
end

# Represents a comment. Comment lines begin with a semi-colon or hash.
#
#   ; this is a comment
#   # also a comment
#
# source://iniparse//lib/iniparse/lines.rb#330
class IniParse::Lines::Comment < ::IniParse::Lines::Blank
  # Returns the inline comment for this line. Includes the comment
  # separator at the beginning of the string.
  #
  # In rare cases where a comment seperator appeared in the original file,
  # but without a comment, just the seperator will be returned.
  #
  # source://iniparse//lib/iniparse/lines.rb#348
  def comment; end

  # Returns if this line has an inline comment.
  #
  # Being a Comment this will always return true, even if the comment
  # is nil. This would be the case if the line starts with a comment
  # seperator, but has no comment text. See spec/fixtures/smb.ini for a
  # real-world example.
  #
  # @return [Boolean]
  #
  # source://iniparse//lib/iniparse/lines.rb#338
  def has_comment?; end
end

# A base class from which other line types should inherit.
#
# source://iniparse//lib/iniparse/lines.rb#4
module IniParse::Lines::Line
  # ==== Parameters
  # opts<Hash>:: Extra options for the line.
  #
  # source://iniparse//lib/iniparse/lines.rb#8
  def initialize(opts = T.unsafe(nil)); end

  # Returns whether this is a line which has no data.
  #
  # @return [Boolean]
  #
  # source://iniparse//lib/iniparse/lines.rb#47
  def blank?; end

  # Returns the inline comment for this line. Includes the comment
  # separator at the beginning of the string.
  #
  # source://iniparse//lib/iniparse/lines.rb#42
  def comment; end

  # Returns if this line has an inline comment.
  #
  # @return [Boolean]
  #
  # source://iniparse//lib/iniparse/lines.rb#18
  def has_comment?; end

  # Returns the contents for this line.
  #
  # source://iniparse//lib/iniparse/lines.rb#36
  def line_contents; end

  # Returns the options used to create the line
  #
  # source://iniparse//lib/iniparse/lines.rb#52
  def options; end

  # Returns this line as a string as it would be represented in an INI
  # document.
  #
  # source://iniparse//lib/iniparse/lines.rb#24
  def to_ini; end
end

# Represents probably the most common type of line in an INI document:
# an option. Consists of a key and value, usually separated with an =.
#
#   key = value
#
# source://iniparse//lib/iniparse/lines.rb#250
class IniParse::Lines::Option
  include ::IniParse::Lines::Line

  # ==== Parameters
  # key<String>::   The option key.
  # value<String>:: The value for this option.
  # opts<Hash>::    Extra options for the line.
  #
  # @return [Option] a new instance of Option
  #
  # source://iniparse//lib/iniparse/lines.rb#265
  def initialize(key, value, opts = T.unsafe(nil)); end

  # Returns the value of attribute key.
  #
  # source://iniparse//lib/iniparse/lines.rb#258
  def key; end

  # Sets the attribute key
  #
  # @param value the value to set the attribute key to.
  #
  # source://iniparse//lib/iniparse/lines.rb#258
  def key=(_arg0); end

  # Returns the value of attribute value.
  #
  # source://iniparse//lib/iniparse/lines.rb#258
  def value; end

  # Sets the attribute value
  #
  # @param value the value to set the attribute value to.
  #
  # source://iniparse//lib/iniparse/lines.rb#258
  def value=(_arg0); end

  private

  # returns an array to support multiple lines or a single one at once
  # because of options key duplication
  #
  # source://iniparse//lib/iniparse/lines.rb#296
  def line_contents; end

  class << self
    # source://iniparse//lib/iniparse/lines.rb#271
    def parse(line, opts); end

    # Attempts to typecast values.
    #
    # source://iniparse//lib/iniparse/lines.rb#279
    def typecast(value); end
  end
end

# Represents a section header in an INI document. Section headers consist
# of a string of characters wrapped in square brackets.
#
#   [section]
#   key=value
#   etc
#   ...
#
# source://iniparse//lib/iniparse/lines.rb#72
class IniParse::Lines::Section
  include ::IniParse::Lines::Line
  include ::Enumerable

  # ==== Parameters
  # key<String>:: The section name.
  # opts<Hash>::  Extra options for the line.
  #
  # @return [Section] a new instance of Section
  #
  # source://iniparse//lib/iniparse/lines.rb#89
  def initialize(key, opts = T.unsafe(nil)); end

  # Returns the value of an option identified by +key+.
  #
  # Returns nil if there is no corresponding option. If the key provided
  # matches a set of duplicate options, an array will be returned containing
  # the value of each option.
  #
  # source://iniparse//lib/iniparse/lines.rb#162
  def [](key); end

  # Adds a new option to this section, or updates an existing one.
  #
  # Note that +[]=+ has no knowledge of duplicate options and will happily
  # overwrite duplicate options with your new value.
  #
  #   section['an_option']
  #     # => ['duplicate one', 'duplicate two', ...]
  #   section['an_option'] = 'new value'
  #   section['an_option]
  #     # => 'new value'
  #
  # If you do not wish to overwrite duplicates, but wish instead for your
  # new option to be considered a duplicate, use +add_option+ instead.
  #
  # source://iniparse//lib/iniparse/lines.rb#145
  def []=(key, value); end

  # Deletes the option identified by +key+.
  #
  # Returns the section.
  #
  # source://iniparse//lib/iniparse/lines.rb#178
  def delete(*args); end

  # Enumerates through each Option in this section.
  #
  # Does not yield blank and comment lines by default; if you want _all_
  # lines to be yielded, pass true.
  #
  # ==== Parameters
  # include_blank<Boolean>:: Include blank/comment lines?
  #
  # source://iniparse//lib/iniparse/lines.rb#127
  def each(*args, &blk); end

  # Returns true if an option with the given +key+ exists in this section.
  #
  # @return [Boolean]
  #
  # source://iniparse//lib/iniparse/lines.rb#193
  def has_option?(key); end

  # Returns the value of attribute key.
  #
  # source://iniparse//lib/iniparse/lines.rb#80
  def key; end

  # Sets the attribute key
  #
  # @param value the value to set the attribute key to.
  #
  # source://iniparse//lib/iniparse/lines.rb#80
  def key=(_arg0); end

  # Returns the value of attribute lines.
  #
  # source://iniparse//lib/iniparse/lines.rb#81
  def lines; end

  # Merges section +other+ into this one. If the section being merged into
  # this one contains options with the same key, they will be handled as
  # duplicates.
  #
  # ==== Parameters
  # other<IniParse::Section>:: The section to merge into this one.
  #
  # source://iniparse//lib/iniparse/lines.rb#204
  def merge!(other); end

  # Like [], except instead of returning just the option value, it returns
  # the matching line instance.
  #
  # Will return an array of lines if the key matches a set of duplicates.
  #
  # source://iniparse//lib/iniparse/lines.rb#188
  def option(key); end

  # Returns this line as a string as it would be represented in an INI
  # document. Includes options, comments and blanks.
  #
  # source://iniparse//lib/iniparse/lines.rb#103
  def to_ini; end

  private

  # source://iniparse//lib/iniparse/lines.rb#218
  def line_contents; end

  class << self
    # source://iniparse//lib/iniparse/lines.rb#95
    def parse(line, opts); end
  end
end

# Raised when an option line is found during parsing before the first
# section.
#
# source://iniparse//lib/iniparse.rb#20
class IniParse::NoSectionError < ::IniParse::ParseError; end

# A implementation of LineCollection used for storing (mostly) Option
# instances contained within a Section.
#
# Whenever OptionCollection encounters an Option key already held in the
# collection, it treats it as a duplicate. This means that instead of
# overwriting the existing value, the value is changed to an array
# containing the previous _and_ the new Option instances.
#
# source://iniparse//lib/iniparse/line_collection.rb#140
class IniParse::OptionCollection
  include ::Enumerable
  include ::IniParse::LineCollection

  # Appends a line to the collection.
  #
  # If you push an Option with a key already represented in the collection,
  # the previous Option will not be overwritten, but treated as a duplicate.
  #
  # ==== Parameters
  # line<IniParse::LineType::Line>:: The line to be added to this section.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#151
  def <<(line); end

  # source://iniparse//lib/iniparse/line_collection.rb#166
  def each(*args); end

  # Return an array containing the keys for the lines added to this
  # collection.
  #
  # source://iniparse//lib/iniparse/line_collection.rb#180
  def keys; end
end

# Raised if an error occurs parsing an INI document.
#
# source://iniparse//lib/iniparse.rb#16
class IniParse::ParseError < ::IniParse::IniParseError; end

# source://iniparse//lib/iniparse/parser.rb#2
class IniParse::Parser
  # Creates a new Parser instance for parsing string +source+.
  #
  # ==== Parameters
  # source<String>:: The source string.
  #
  # @return [Parser] a new instance of Parser
  #
  # source://iniparse//lib/iniparse/parser.rb#31
  def initialize(source); end

  # Parses the source string and returns the resulting data structure.
  #
  # ==== Returns
  # IniParse::Document
  #
  # source://iniparse//lib/iniparse/parser.rb#40
  def parse; end

  class << self
    # Takes a raw line from an INI document, striping out any inline
    # comment, and indent, then returns the appropriate tuple so that the
    # Generator instance can add the line to the Document.
    #
    # ==== Raises
    # IniParse::ParseError: If the line could not be parsed.
    #
    # source://iniparse//lib/iniparse/parser.rb#56
    def parse_line(line); end

    # Returns the line types.
    #
    # ==== Returns
    # Array
    #
    # source://iniparse//lib/iniparse/parser.rb#9
    def parse_types; end

    # Sets the line types. Handy if you want to add your own custom Line
    # classes.
    #
    # ==== Parameters
    # types<Array[IniParse::Lines::Line]>:: An array containing Line classes.
    #
    # source://iniparse//lib/iniparse/parser.rb#19
    def parse_types=(types); end

    private

    # Strips in inline comment from a line (or value), removes trailing
    # whitespace and sets the comment options as applicable.
    #
    # source://iniparse//lib/iniparse/parser.rb#79
    def strip_comment(line, opts); end

    # Removes any leading whitespace from a line, and adds it to the options
    # hash.
    #
    # source://iniparse//lib/iniparse/parser.rb#100
    def strip_indent(line, opts); end
  end
end

# A implementation of LineCollection used for storing (mostly) Option
# instances contained within a Section.
#
# Since it is assumed that an INI document will only represent a section
# once, if SectionCollection encounters a Section key already held in the
# collection, the existing section is merged with the new one (see
# IniParse::Lines::Section#merge!).
#
# source://iniparse//lib/iniparse/line_collection.rb#112
class IniParse::SectionCollection
  include ::Enumerable
  include ::IniParse::LineCollection

  # source://iniparse//lib/iniparse/line_collection.rb#115
  def <<(line); end
end

# source://iniparse//lib/iniparse.rb#10
IniParse::VERSION = T.let(T.unsafe(nil), String)
