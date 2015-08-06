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

src_repo = ARGV[0]
dst_repo = ARGV[1]

if src_repo.nil? || dst_repo.nil?
  logger.error("Need src repo and dst repo in parameters")
  exit
end

logger.info("Sync #{src_repo} to #{dst_repo}")

begin
  src_labels = Octokit.labels src_repo
rescue
  logger.error("Trouble with #{src_repo} access")
  exit
end

begin
  dst_labels = Octokit.labels dst_repo
rescue
  logger.error("Trouble with #{dst_repo} access")
  exit
end

logger.info("Remaining github api calls : " + Octokit.last_response.headers[:x_ratelimit_remaining])

src_labels.each do |label|
  logger.debug("Label -> #{label['name']}, color -> #{label['color']} from #{src_repo} is present in #{dst_repo} ?")
  begin
    label_dst = Octokit.label(dst_repo, label['name'])
    logger.debug("Yes --> color is okay ?")
    if label['color'] != label_dst['color']
      logger.info("Need to update #{label['name']} color to #{label['color']}")
      Octokit.update_label(dst_repo, label['name'], {:color => label['color']})
    else
      logger.debug("Yes")
    end
  rescue
    logger.info("No --> creation #{label['name']}")
    Octokit.add_label(dst_repo, label['name'], label['color'])
  end
end

logger.debug("Remaining github api calls : " + Octokit.last_response.headers[:x_ratelimit_remaining])

logger.debug("Verify if there is not too much labels in #{dst_repo}")

dst_labels.each do |label|
  logger.debug("Label -> #{label['name']}, color -> #{label['color']} from #{dst_repo} is present in #{src_repo} ?")
  begin
    Octokit.label(src_repo, label['name'])
    logger.debug("Yes")
  rescue
    logger.info("No --> delete #{label['name']}")
    # http://stackoverflow.com/a/612588/4809513
    Octokit.delete_label!(dst_repo, label['name'])
  end
end

logger.info("Remaining github api calls : " + Octokit.last_response.headers[:x_ratelimit_remaining])
