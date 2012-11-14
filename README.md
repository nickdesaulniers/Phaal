# Phaal

2D shooter made in the image of one of my favorite childhood video games

## Dependencies

### Git
http://git-scm.com/downloads

### Ruby
Check your ruby version number with `ruby -v`, I'm using `ruby 1.9.3p269 (2012-09-09 revision 36939) [x86_64-darwin12.1.0]`

To install Ruby through rvm:
```
\curl -L https://get.rvm.io | bash -s stable --ruby
rvm install 1.9.3-head
```
make sure you add the `[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"` to your .bashrc or .zshrc, etc.

### Download source code
`git clone git://github.com/nickdesaulniers/Phaal.git && cd Phaal`

### Bundler
I had a weird issue with a less than up to data version of bundler.
Check your bundler version: `bundler -v`, I'm using `Bundler version 1.2.0`
Install bundler with `gem install bundler` or update bundler with `gem update bundler`

### Gems
Install library dependencies (gems)
`bundle install`

### Migrating the database
Setup database, by running the migration:
`rake db:migrate` or `rake db:migrate RAILS_ENV=production`

### Precompiling the assets
Optional, for running in production
`rake assets:precompile`

## Running
Run the server:
`rails s` or `rvmsudo rails s -p 80 -e production`

## Playing
Open the page:
`open localhost:3000` or `open localhost`
Movement:
the chat bar must not have focus (click out of it)
`w` - Up
`a` - Left
`s` - Down
`d` - left
Chat:
the chat bar needs to have focus (click in it)
`Enter` or `Return` to send
