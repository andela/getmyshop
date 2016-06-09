module DummyHelper
  def sentence(word_count=4,suplemental=false)
    Faker::Lorem.sentence(word_count,suplemental)
  end

  def date(direction, days)
    case direction
    when "backward" 
      Faker::Date.backward(days)
    when "forward"
      Faker::Date.forward(days)
    end
  end

  def name(type)
    case type
    when "fullname"
      Faker::Name.name
    when "firstname"
      Faker::Name.first_name
    when "lastname"
      Faker::Name.last_name
    when "prefix"
      Faker::Name.prefix
    when "suffix"
      Faker::Name.suffix
    when "title"
      Faker::Name.title
    end
  end

  def paragraph(length)
    Faker::Lorem.paragraph(length)
  end

  def image(slug = nil, size = "300x300")
    Faker::Avatar.image(slug, size)
  end

  def words(number, join = false)
    case join
    when true
      Faker::Lorem.words(number).join(" ")
    else
      Faker::Lorem.words(number)
    end
  end
end
