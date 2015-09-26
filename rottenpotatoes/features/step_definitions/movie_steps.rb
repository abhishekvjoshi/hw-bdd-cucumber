# Add a declarative step here for populating the DB with movies.


Given /the following movies exist/ do |movies_table|
  @all_ratings = {'G'=>false,'PG'=>false,'PG-13'=>false,'R'=>false}
  @movie_table = movies_table
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	Movie.create movie
	#puts movie[:rating]
	if @all_ratings.has_key?(movie[:rating])
		@all_ratings[movie[:rating]] = true
	else
		@all_ratings[movie[:rating]] = true
	end
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert(page.body.index(e1) < page.body.index(e2))
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(%r{,\s*})
  puts ratings
  puts @all_ratings
  if uncheck
    ratings.each do |r|
      page.uncheck("ratings_#{r}")
	  @all_ratings[r] = false
    end
  else
    ratings.each do |r|
      page.check("ratings_#{r}") #step "I check \"#{r}\""
	  @all_ratings[r] = true
    end
  end
  #fail "Unimplemented"
end

Then /I should see the movies: (.*)/ do |rating_list|
	movies = rating_list.split(%r{,\s*})
	
	movies.each do |r|
		step "I should see \"#{r}\""	
	end
	
end

Then /I should not see the ratings: (.*)/ do |rating_list|
	ratings = rating_list.split(%r{,\s*})
	ratings.each do |r|
		step "I should not see \"#{r}\""	
	end
	
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #fail "Unimplemented"
  #puts Movie.all
  @movie_table.hashes.each do |m|
	step "I should see \"#{m[:title]}\""
  end
end
