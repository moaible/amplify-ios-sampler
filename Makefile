init:
	bundle install
	bundle exec pod install
setup-amplify-cli:
	npm install -g @aws-amplify/cli@4.26.0