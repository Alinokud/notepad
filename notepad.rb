if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'post.rb'
require_relative 'link.rb'
require_relative 'task.rb'
require_relative 'memo.rb'

puts "Привет, я твой блокнот!"
puts "Что хотите записать в блокнот?"

choices = Post.post_types

choice = -1

until choice >= 0 && choice < choices.size # пока юзер не выбрал правильно
  # выводим заново массив возможных типов поста
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end
  choice = gets.chomp.to_i
end

# выбор сделан, создаем запись с помощью стат. метода класса Post
entry = Post.create(choice)

# сейчас в переменной entry лежит один из детей класса Post, какой именно,
# определилось выбором пользователя, переменной choice.
# Но мы не знаем какой, и обращаемся с entry как с объектом класса Post, этого оказывается достаточно.

# Просим пользователя ввести пост (каким бы он ни был)
entry.read_from_console

# Сохраняем пост в файл
entry.save

puts "Ваша запись сохранена!"
