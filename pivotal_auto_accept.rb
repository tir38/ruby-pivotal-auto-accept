#!/usr/bin/ruby

require 'tracker_api'

String token = ENV["PIVOTAL_TOKEN"]
Integer project_number = ENV["PIVOTAL_PROJECT_NUMBER"].to_i
Integer auto_accept_after_days = ENV["PIVOTAL_ACCEPT_AFTER_DAYS"].to_i


String delivered_state = 'delivered'
String accepted_state = 'accepted'

updated_at_least_one_story = false

client = TrackerApi::Client.new(token: token) # Create API client

project = client.project(project_number) # Find project with given ID
stories = project.stories(with_state: :delivered) # Get all delivered stories

puts 'Found ' + stories.size.to_s + ' delivered stories in ' + project.name + '.'

stories.each { |story|
  story_transitions = story.transitions.reverse

  newest_transition = story_transitions.first

  story_transitions.each { |transition|
    if transition.occurred_at > newest_transition.occurred_at
      newest_transition = transition # update
    end
  }

  # we can assume that newest transition is "delivered"

  occurred = newest_transition.occurred_at.to_date

  if occurred < (Date.today() - auto_accept_after_days)
    # mark story as accepted
    story.current_state = accepted_state

    # add comment that auto accepted after X days
    message = 'This story has been auto accepted after ' + auto_accept_after_days.to_s + ' days.'
    story.create_comment(text: message)

    story.save

    puts story.name + '...marked as accepted'
    updated_at_least_one_story = true
  end
}

unless updated_at_least_one_story
  puts 'Finished. No stories needed updating.'
end



