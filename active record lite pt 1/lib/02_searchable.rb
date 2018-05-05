require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    condition = params.map { |param, _| "#{param} = ?" }.join(" AND ")

    result = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{condition}
    SQL

    self.parse_all(result)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
