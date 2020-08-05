init:
	bundle config set path 'vendor/bundle'
	amplify pull
install-frontend-lib:
	bundle install
	bundle exec pod install --repo-update
setup-amplify:
	npm install -g @aws-amplify/cli@4.26.0
	amplify configure
deploy-backend:
	amplify push
