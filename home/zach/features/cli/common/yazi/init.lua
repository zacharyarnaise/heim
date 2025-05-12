require("full-border"):setup{
    type = ui.Border.ROUNDED
}

require("git"):setup()

require("yatline"):setup({
    theme = require("yatline-catppuccin"):setup("macchiato"),
    show_background = false,
    display_header_line = true,
    display_status_line = true,
    component_positions = {"header", "tab", "status"},

    header_line = {
        left = {
            section_a = {{
                type = "line",
                custom = false,
                name = "tabs",
                params = {"left"}
            }},
            section_b = {{
                type = "string",
                custom = false,
                name = "tab_path",
                params = {
                    trimmed = false,
                    max_length = 24,
                    trim_length = 10
                }
            }},
            section_c = {}
        },
        right = {
            section_a = {},
            section_b = {},
            section_c = {}
        }
    },

    status_line = {
        left = {
            section_a = {{
                type = "string",
                custom = false,
                name = "tab_mode"
            }},
            section_b = {{
                type = "string",
                custom = false,
                name = "hovered_size"
            }},
            section_c = {{
                type = "string",
                custom = false,
                name = "hovered_name"
            }, {
                type = "coloreds",
                custom = false,
                name = "count"
            }}
        },
        right = {
            section_a = {{
                type = "string",
                custom = false,
                name = "cursor_position"
            }},
            section_b = {{
                type = "string",
                custom = false,
                name = "cursor_percentage"
            }},
            section_c = {{
                type = "string",
                custom = false,
                name = "hovered_file_extension",
                params = {true}
            }, {
                type = "coloreds",
                custom = false,
                name = "permissions"
            }}
        }
    }
})

function Linemode:mtime_custom()
    local mtime = (self._file.cha.mtime or 0) // 1
    if mtime > 0 then
        if os.date("%Y", mtime) == os.date("%Y") then
            mtime = os.date("%d/%m %H:%M", mtime)
        else
            mtime = os.date("%d/%m/%Y", mtime)
        end
    end

    local size = self._file:size()
    if size then
      size = ya.readable_size(size):gsub(" ", "")
      return ui.Line(string.format(" %s %s ", size, mtime))
    else
      return ui.Line(string.format(" %s ", mtime))
    end
end
