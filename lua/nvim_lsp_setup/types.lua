---@class nvimLspSetupOption
---@field hover? hoverConfig
---@field diagnostic? diagnosticConfig
---@field signature_help? signatureHelpConfig

--- 'width' and 'height' are always required.
--- 'relative' or 'external' is required.
--- 'relative' requires 'row'/'col' or 'bufpos'.
---@class hoverConfig # :h nvim_open_win()
---@field relative
---| "editor" # The global editor grid
---| "win" # Window given by the `win` field, or current window.
---| "cursor" # Cursor position in current window.
---| "mouse" # Mouse position
---@field win number
---@field anchor
---| "NW" # northwest (default)
---| "NE" # northeast
---| "SW" # southwest
---| "SE" # southeast
---@field width number # Window width (in character cells). Minimum of 1.
---@field height number # Window height (in character cells). Minimum of 1.
---@field bufpos number[] # A tuple of zero-indexed [line, column].
---@field row number # Row position in units of "screen cell height", may be fractional.
---@field col number # Column position in units of "screen cell width", may be fractional.
---@field focusable boolean # Enable focus by user actions (wincmds, mouse events). Defaults to true. Non-focusable windows can be entered by |nvim_set_current_win()|.
---@field external boolean # GUI should display the window as an external top-level window. Currently accepts no other positioning configuration together with this.
---@field zindex number # Stacking order. floats with higher `zindex` go on top on floats with lower indices. Must be larger than zero.
---@field style "minimal" # Currently only "minimal".
---@field border border
---@field title string | string[] # Title (optional) in window border, String or list. List is [text, highlight] tuples. if is string the default highlight group is `FloatTitle`.
---@field title_pos
---| "left" # default
---| "center"
---| "right"
---@field noautocmd boolean # If true then no buffer-related autocommand events such as |BufEnter|, |BufLeave| or |BufWinEnter| may fire from calling this function.

---@alias border
---| "none" # No border (default)
---| "single" # A single line box
---| "double" # A double line box
---| "rounded" # Like "single", but with rounded corners ("╭" etc.).
---| "solid" # Adds padding by a single whitespace cell.
---| "shadow" # A drop shadow effect by blending with the background.
---| string[]

--- Each of the configuration options below accepts one of the following:
--- • `false`: Disable this feature
--- • `true`: Enable this feature, use default settings.
--- • `table`: Enable this feature with overrides. Use an empty table to
---   use default values.
--- • `function`: Function with signature (namespace, bufnr) that returns
---   any of the above.
---@class diagnosticConfig # :h vim.diagnostic.config()
---@field underline boolean | diagnosticConfigUnderline
---@field virtual_text boolean | diagnosticConfigVertualText # default: true
---@field signs boolean | diagnosticConfigSigns # default: true
---@field float diagnosticConfigFloat
---@field update_in_insert boolean # (default false) Update diagnostics in Insert mode (if false, diagnostics are updated on InsertLeave).
---@field severity_sort boolean | diagnosticConfigSeveritySort # default: false

--- Use underline for diagnostics.
---@class diagnosticConfigUnderline
---@field severity vim.diagnostic.severity # Only underline diagnostics matching the given severity |diagnostic-severity|.

--- Use virtual text for diagnostics. If multiple diagnostics are set for a
--- namespace, one prefix per diagnostic + the last diagnostic message are shown.
---@class diagnosticConfigVertualText
---@field severity vim.diagnostic.severity # Only show virtual text for diagnostics matching the given severity |diagnostic-severity|.
---@field source boolean | string # Include the diagnostic source in virtual text. Use "if_many" to only show sources if there is more than one diagnostic source in the buffer. Otherwise, any truthy value means to always show the diagnostic source.
---@field spacing number # Amount of empty spaces inserted at the beginning of the virtual text.
---@field prefix string # Prepend diagnostic message with prefix.
---@field suffix string | diagnosticFormatFunction # Append diagnostic message with suffix. If a function, it must have the signature (diagnostic) -> string, where {diagnostic} is of type |diagnostic-structure|. This can be used to render an LSP diagnostic error code.
---@field format diagnosticFormatFunction # A function that takes a diagnostic as input and returns a string. The return value is the text used to display the diagnostic.

--- Use signs for diagnostics.
---@class diagnosticConfigSigns
---@field severity vim.diagnostic.severity # Only show signs for diagnostics matching the given severity |diagnostic-severity|.
---@field priority number # (default 10) Base priority to use for signs. When {severity_sort} is used, the priority of a sign is adjusted based on its severity. Otherwise, all signs use the same priority.

---@class diagnosticConfigFloat
---@field bufnr number # Buffer number to show diagnostics from. Defaults to the current buffer.
---@field namespace number # Limit diagnostics to the given namespace.
---@field scope # Show diagnostics from
---| "buffer" # the whole buffer
---| "line" # the current line (default)
---| "cursor" # the current cursor position
---| "b" # Shorthand for "buffer".
---| "l" # Shorthand for "line".
---| "c" # Shorthand for "cursor".
---@field pos number | number[] # If a number, interpreted as a line number; otherwise, a (row, col) tuple.
---@field severity_sort diagnosticConfigSeveritySort | boolean
---@field severity vim.diagnostic.severity
---@field header string | string[] # If a table, it is interpreted as a [text, hl_group] tuple.
---@field source boolean | string
---@field format diagnosticFormatFunction # A function that takes a diagnostic as input and returns a string. The return value is the text used to display the diagnostic.
---@field prefix diagnosticFix # Prefix each diagnostic in the floating window.
---@field suffix diagnosticFix # Suffix each diagnostic in the floating window.

--- Sort diagnostics by severity.
--- This affects the order in which signs and virtual text are displayed.
--- When true, higher severities are displayed before lower severities (e.g. ERROR is displayed before WARN).
---@class diagnosticConfigSeveritySort
---@field reverse boolean # Reverse sort order.

---@class vim.diagnostic.severity
---@field ERROR 1
---@field WARN 2
---@field INFO 3
---@field HINT 4
---@field E 1 # Alias to ERROR
---@field W 2 # Alias to WARN
---@field I 3 # Alias to INFO
---@field H 4 # Alias to HINT

---@class diagnosticStructure
---@field bufnr? number # Buffer number
---@field lnum number # The starting line of the diagnostic
---@field end_lnum? number # The final line of the diagnostic
---@field col number # The starting column of the diagnostic
---@field end_col? number # The final column of the diagnostic
---@field severity? vim.diagnostic.severity # The severity of the diagnostic |vim.diagnostic.severity|
---@field message string # The diagnostic text
---@field source? string # The source of the diagnostic
---@field code? string # The diagnostic code
---@field user_data any # Arbitrary data plugins or users can add

---@alias diagnosticFormatFunction fun(diagnostic: diagnosticStructure): string

---@alias diagnosticFix
---| string # It is prepended to each diagnostic in the window with no highlight.
---| string[] # [text, hl_group] tuple as in |nvim_echo()|.
---| fun(diagnostic: diagnosticStructure, i: number, total: number): string, string? # Where {i} is the index of the diagnostic being evaluated and {total} is the total number of diagnostics displayed in the window. The function should return a string which is prepended to each diagnostic in the window as well as an (optional) highlight group which will be used to highlight the prefix.

---@class signatureHelpConfig
---@field border border # (default nil) Add borders to the floating window.
