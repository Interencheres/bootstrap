# https://github.com/rest-client/rest-client
require 'octokit'
require 'logger'
require 'pp'

require_relative 'config'

logger = Logger.new(STDOUT)
logger.level = LOGGER_LEVEL

Octokit.configure do |c|
  c.access_token = ACCESS_TOKEN
end

src_repo = SRC_REPO
dst_repo = DST_REPO

dst_labels = Octokit.labels dst_repo

logger.info("Remaining github api calls : " + Octokit.last_response.headers[:x_ratelimit_remaining])

dst_labels.each do |label|
  logger.info("Delete from #{dst_repo} : label : #{label['name']}, colo : #{label['color']}")
  Octokit.delete_label!(dst_repo, label['name'])
end
logger.info("Remaining github api calls : " + Octokit.last_response.headers[:x_ratelimit_remaining])

src_labels = Octokit.labels src_repo

logger.info("Remaining github api calls : " + Octokit.last_response.headers[:x_ratelimit_remaining])

src_labels.each do |label|
  logger.info("Creation from #{src_repo} to #{dst_repo} : label -> #{label['name']}, color -> #{label['color']}")
  Octokit.add_label(dst_repo, label['name'], label['color'])
end

logger.info("Remaining github api calls : " + Octokit.last_response.headers[:x_ratelimit_remaining])
