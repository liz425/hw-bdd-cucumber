# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating|
    rating = "ratings_#{rating}"
    steps %Q{
      When I #{uncheck ? "uncheck":"check"} "#{rating}"
    }
  end
end

Then /I should see all (of )?the movies/ do |ignore|
  # Make sure that all the movies in the app are visible in the table
  rows = page.all('table#movies tbody tr').count
  rows.should == 10
end

# Check whether movies of designated ratings are seen or not

Then /I should (not )?see movies of rating: (.*)/ do |should_not, rating_list|
  rating_list.split(/,\s*/).each do |rating|
    Movie.where(rating:rating).each do |movie|
      step %Q{I should #{should_not}see "#{movie.title}"}
      end
    #The following attempt won't work well since it can't distinguish between 'G' and 'PG'
    #expect(page).to have_xpath('//td', :text => "#{rating}")
  end
end



