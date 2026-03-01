require("full-border"):setup()
require("git"):setup()
require("yamb"):setup({
    path = os.getenv("HOME") .. "/.config/yazi/bookmarks.db",
})
