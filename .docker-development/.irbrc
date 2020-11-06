# ~/.irbrc

require 'irb/ext/save-history'
require 'irb/completion'

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 10_000
IRB.conf[:HISTORY_FILE] = "~/app/log/.irb-history"
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
