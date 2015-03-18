# Maps with Friends
Status: Feature additions are pending.

A User can:
- register
- login
- have markers display on the map for all of the friends in the database associated with the user
- add new friend markers to the map
- See names and locations their friends

## Why Maps with Friends?
Life has a way of scattering friends all over the place.
Sometimes it's hard to keep track of where everyone is, especially amidst career changes, college or grad school, and other life events.
Maps with Friends aims to provide a simple visual application to show where your friends are located.

## Technologies
- Sinatra framework
- AJAX
- Google Maps API
- Skeleton CSS

##  How to Use
- `git clone <url>`
- `bundle install`
- `bundle exec db:create`
- `bundle exec db:migrate`
- `bundle exec shotgun`
- navigate browser to localhost:9393
- register and log in
- Add friends to map by filling out form
- Enjoy!
