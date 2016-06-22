# Joinme2
Simple Ruby wrapper for the JoinMe API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'joinme2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install joinme2

## Usage

```ruby
Joinme2.configure do |config|
  config.client_id = 'CLIENT_ID'
  config.redirect_uri = 'REDIRECT_URI'
end

joinme = Joinme2.client(oauth_token: 'OAUTH_TOKEN')
# => #<Joinme2::Client:0x00000003d96ab8...

joinme.authorize_url
# => "https://secure.join.me/api/public/v1/auth/oauth2?..."

joinme.start_new_meeting
# => {"presenterLink"=>"https://secure.join.me/API/Public/StartMeeting.aspx?token=TOKEN",
      "viewerLink"=>"https://secure.join.me/LINK_ID",
      "audioConference"=>
        {"conferenceId"=>"CONFERENCE_ID",
         "conferenceCallNumbersUrl"=>"https://secure.join.me/api/public/intphone.aspx?conferenceId=CONFERENCE_ID",
         "organizerCode"=>"CODE"}}

joinme.schedule_new_meeting('Test Meeting',
                            ['ex1@example.com', 'ex2@example.com'],
                            '2016-06-21T16:00:00+02:00',
                            '2016-06-21T17:00:00+02:00')
# => {"meetingId"=>23,
#     "meetingName"=>"Test Meeting",
#     "meetingStart"=>"2016-06-21T14:00:00Z",
#     "meetingEnd"=>"2016-06-21T15:00:00Z",
#     "startWithPersonalUrl"=>false,
#     "participants"=>["ex1@example.com", "ex2@example.com"]}

joinme.update_meeting(23, 'Updated Name',
                          ['up1@example.com', 'up2@example.com'],
                          '2016-07-21T16:00:00+02:00',
                          '2016-07-21T17:00:00+02:00')

joinme.delete_meeting(23)

joinme.get_user
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/joinme2.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

