require "logger"
require "colorize"

module Shards
  LOGGER_COLORS = {
    "ERROR" => :red,
    "WARN"  => :orange,
    "INFO"  => :light_green,
    "DEBUG" => :light_gray,
  }

  @@colors = true

  def self.colors=(value)
    @@colors = value
  end

  def self.logger
    @@logger ||= Logger.new(STDOUT).tap do |logger|
      logger.progname = "shards"
      logger.level = Logger::Severity::INFO

      logger.formatter = Logger::Formatter.new do |severity, _datetime, _progname, message, io|
        if @@colors
          io << if color = LOGGER_COLORS[severity.to_s]?
                  message.colorize(color)
                else
                  message
                end
        else
          io << severity[0] << ": " << message
        end
      end
    end
  end
end