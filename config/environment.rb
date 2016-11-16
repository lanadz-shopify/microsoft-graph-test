###
#  Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
#  See LICENSE in the project root for license information.
##

# The following values must match the client ID, key, and reply URL
# in your Azure application.

ENV['LOGOUT_ENDPOINT'] = ''
ENV['CLIENT_ID'] = ''
ENV['CLIENT_SECRET'] = ''
ENV['TENANT'] = ''
ENV['REPLY_URL'] = 'http://localhost:3000/auth/azureactivedirectory/callback'

# Load the Rails application.
require File.expand_path('../application', __FILE__)

ADAL::Logging.log_level = ADAL::Logger::VERBOSE

Rails.logger = Logger.new(STDOUT)

# Initialize the Rails application.
Rails.application.initialize!
