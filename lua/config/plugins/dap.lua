return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        { 
            "theHamsta/nvim-dap-virtual-text",
            dependencies = {
                "nvim-neotest/nvim-nio",
            },
        },
    },

    keys = {
        "<F1>",
        "<F7>",
    },

    config = function()
        local dap = require("dap")
        local ui  = require("dapui")

        require("dapui").setup({
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.6,
                        },
                        {
                            id = "stacks",
                            size = 0.4,
                        },
                    },
                    position = "left",
                    size = 80,
                },
            },
            element_mappings = {
                stacks = {
                    open = "<CR>",
                    expand = "o",
                },
            },
        })

        require("nvim-dap-virtual-text").setup({})

        dap.set_log_level("DEBUG")

        dap.adapters.lldb = {
            type    = "executable",
            command = "/Library/Developer/CommandLineTools/usr/bin/lldb-dap",
            name    = "lldb",
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = function()
                    return require("dap.utils").pick_file()
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
            {
                name = "Attach",
                type = "lldb",
                request = "attach",
                pid = function() 
                    return require("dap.utils").pick_process()
                end,
            },
        }

        dap.configurations.c = dap.configurations.cpp

        local function map(keys, func)
            vim.keymap.set("n", keys, func)
        end

        -- a[dd] b[reakpoint]
        map("<leader>ab", dap.toggle_breakpoint)

        -- launch
        map("<F1>", function()
            dap.run(dap.configurations.cpp[1], {})
        end)
        -- attach
        map("<F7>", function()
            dap.run(dap.configurations.cpp[2], {})
        end)

        map("<F2>", dap.step_into)
        map("<F3>", dap.step_over)
        map("<F4>", dap.step_out)
        map("<F5>", dap.continue)
        map("<F6>", function()
            dap.terminate()
            ui.close()
        end)

        dap.listeners.after.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.after.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end
}
