# encoding: UTF-8
#
namespace :update_db_shop do
  desc 'Обновление базы данных с сайта my-shop.ru'
  task import: :environment do
    IO.popen("curl http://my-shop.ru/_files/prices/partner.sql.gz -L | zgrep --text  INSERT  | sed 's/INSERT/REPLACE/' | iconv -f cp1251 -t utf8") do |f|
       while !f.eof?
         sql_line = f.gets
         ActiveRecord::Base.connection.execute(sql_line)
       end
    end
  end
end
