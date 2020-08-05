init:
	bundle config set path 'vendor/bundle'
	amplify pull
update:
	bundle install
	bundle exec pod install
setup-amplify-cli:
	npm install -g @aws-amplify/cli@4.26.0
	amplify configure
