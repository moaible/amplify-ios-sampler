init:
	bundle config set path 'vendor/bundle'
	amplify pull
install:
	bundle install
	bundle exec pod install
setup-amplify-cli:
	npm install -g @aws-amplify/cli@4.26.0
	amplify configure
setup-amplify-analytics:
	amplify add analytics
deploy-backend:
	amplify push
