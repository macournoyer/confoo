require "#{RAILS_ROOT}/vendor/em-mysql/lib/em/mysql"
require "thin"
require "thin/async"
require "json"

EventedMysql.settings.update :database => "muffins_development",
                             :user => "root",
                             :encoding => "utf8",
                             :connections => 4

class RandomRecipe
  SQL = "SELECT title, description FROM recipes ORDER BY RAND()"

  def self.call(env)
    if env["PATH_INFO"] =~ %r{^/recipes2/random.json}
      response = Thin::AsyncResponse.new(env)

      EventedMysql.select(SQL) do |results|
        response << results.first.to_json
        response.done
      end

      response.finish
      
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
