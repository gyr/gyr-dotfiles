-- https://mwop.net/blog/2024-07-04-how-i-use-wezterm.html
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

-- Decide whether cmd represents a default startup invocation
function is_default_startup(cmd)
    if not cmd then
        -- we were started with `wezterm` or `wezterm start` with
        -- no other arguments
        return true
    end
    if cmd.domain == "DefaultDomain" and not cmd.args then
        -- Launched via `wezterm start --cwd something`
        return true
    end
    -- we were launched some other way
    return false
end

wezterm.on('gui-startup', function(cmd)
    if is_default_startup(cmd) then
        -- for the default startup case, we want to switch to the unix domain instead
        local unix = mux.get_domain("unix")
        mux.set_default_domain(unix)
        -- ensure that it is attached
        unix:attach()
    end
end)

config = {
    automatically_reload_config = true,
    default_cursor_style = 'BlinkingBlock',

    -- WINDOW
    -- Disable the title bar and border
    window_decorations = 'RESIZE',
    -- window_background_opacity = 0.95,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    scrollback_lines = 10000,

    -- COLOR
    -- color_scheme = 'Wryan',
    -- color_scheme = 'JWR dark (terminal.sexy)',
    -- color_scheme = 'FarSide (terminal.sexy)',
    -- color_scheme = 'Kasugano (terminal.sexy)',
    --
    -- color_scheme = 'Grayscale (light) (terminal.sexy)',
    -- color_scheme = 'Grayscale (dark) (terminal.sexy)',
    -- color_scheme = 'Mono Theme (terminal.sexy)',
    -- color_scheme = 'City Streets (terminal.sexy)',
    -- color_scheme = 'Red Phoenix (terminal.sexy)',
    color_scheme = 'Tomorrow Night Burns',
    --
    -- color_scheme = 'matrix',
    -- color_scheme = 'Icy Dark (base16)',
    -- color_scheme = 'Gotham (Gogh)',

    -- TAB
    -- Don't let any individual tab name take too much room
    tab_max_width = 32,
    -- Switch to the last active tab when I close a tab
    switch_to_last_active_tab_when_closing_tab = true,
    hide_tab_bar_if_only_one_tab = true,
    -- enable_tab_bar = false,

    -- MUX
    unix_domains = {
        {
            name = 'unix',
        },
    },
    default_gui_startup_args = { 'connect', 'unix' },

    -- KEYMAP
    leader = {
        key = 'a',
        mods = 'CTRL',
        timeout_miliseconds = 2000,
    },
    keys = {
        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        {
            key = 'a',
            mods = 'LEADER|CTRL',
            action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
        },
        -- copy mode
        {
            key = '[',
            mods = 'LEADER',
            action = act.ActivateCopyMode,
        },
        -- search mode
        {
            key = '/',
            mods = 'LEADER',
            action = act.Search {
                CaseSensitiveString="",
            },
        },
        -- TAB
        {
            key = 'c',
            mods = 'LEADER',
            action = act.SpawnTab 'CurrentPaneDomain',
        },
        {
            key = 'n',
            mods = 'LEADER',
            action = act.ActivateTabRelative(1),
        },
        {
            key = 'p',
            mods = 'LEADER',
            action = act.ActivateTabRelative(-1),
        },
        {
            key = ',',
            mods = 'LEADER',
            action = act.PromptInputLine {
                description = 'Enter new name for tab',
                action = wezterm.action_callback(
                    function(window, pane, line)
                        if line then
                            window:active_tab():set_title(line)
                        end
                    end
                ),
            },
        },
        {
            key = 'w',
            mods = 'LEADER',
            action = act.ShowTabNavigator,
        },
        {
            key = '&',
            mods = 'LEADER|SHIFT',
            action = act.CloseCurrentTab{ confirm = true },
        },
        -- PANEL
        {
            key = 'z',
            mods = 'LEADER',
            action = act.TogglePaneZoomState,
        },
        {
            key = '|',
            mods = 'LEADER|SHIFT',
            action = act.SplitPane {
                direction = 'Right',
                size = { Percent = 50 },
            },
        },
        {
            key = '-',
            mods = 'LEADER',
            action = act.SplitPane {
                direction = 'Down',
                size = { Percent = 50 },
            },
        },
        {
            key = ';',
            mods = 'LEADER',
            action = act.ActivatePaneDirection('Prev'),
        },
        {
            key = 'o',
            mods = 'LEADER',
            action = act.ActivatePaneDirection('Next'),
        },
        {
            key = 'h',
            mods = 'LEADER',
            action = act.ActivatePaneDirection('Left'),
        },
        {
            key = 'j',
            mods = 'LEADER',
            action = act.ActivatePaneDirection('Down'),
        },
        {
            key = 'k',
            mods = 'LEADER',
            action = act.ActivatePaneDirection('Up'),
        },
        {
            key = 'l',
            mods = 'LEADER',
            action = act.ActivatePaneDirection('Right'),
        },
        {
            key = '{',
            mods = 'LEADER|SHIFT',
            action = act.PaneSelect { mode = 'SwapWithActiveKeepFocus' }
        },
        -- WORKSPACE
        {
            key = 'a',
            mods = 'LEADER',
            action = act.AttachDomain 'unix',
        },
        {
            key = 'd',
            mods = 'LEADER',
            action = act.DetachDomain { DomainName = 'unix' },
        },
        {
            key = 's',
            mods = 'LEADER',
            action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
        },
        {
            key = '$',
            mods = 'LEADER|SHIFT',
            action = act.PromptInputLine {
                description = 'Enter new name for session',
                action = wezterm.action_callback(
                    function(window, pane, line)
                        if line then
                            mux.rename_workspace(
                                window:mux_window():get_workspace(),
                                line
                            )
                        end
                    end
                ),
            },
        },
    },
}

return config

-- vim: set filetype=lua fileformat=unix foldmethod=indent
