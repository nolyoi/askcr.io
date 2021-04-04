require "./base"

module Avram::Migrator::Columns::PrimaryKeys
  class Int32PrimaryKey < Base
    def initialize(@name)
    end

    def column_type : String
      "serial"
    end
  end
end
