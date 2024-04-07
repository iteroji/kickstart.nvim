local vim = vim
local fn = vim.fn
local api = vim.api
local M = {}

-- Function to execute shell commands and return output
function M.shell(cmd)
  local result = fn.system(cmd)
  if vim.v.shell_error ~= 0 then
      api.nvim_err_writeln("Command failed: " .. cmd .. "\n" .. result)
    return nil
  end
  return result
end

-- Function to get the build directory
function M.getBuildDir()
  local buildDir = M.shell("swift build --show-bin-path")
    return fn.trim(buildDir) -- Remove trailing newline
    end


-- Function to parse package description for executable targets
function M.getExecutableTargets()
  local desc = M.shell("swift package describe --type json")
    if not desc then return {} end

      local parsedDesc, _, err = fn.json_decode(desc)
        if err then
            api.nvim_err_writeln("Error parsing package description: " .. err)
                return {}
                  end

                    local targets = {}
                      for _, package in ipairs(parsedDesc["targets"]) do
                          if package["type"] == "executable" then
                                table.insert(targets, package["name"])
                                    end
                                      end
                                        return targets
                                        end


-- Function to update nvim-dap configuration for Swift
function M.updateSwiftDapConfig(dap)
  local buildDir = M.getBuildDir()  local buildDir = M.getBuildDir()
    local targets = M.getExecutableTargets()
      if not buildDir or vim.tbl_isempty(targets) then
          api.nvim_err_writeln("No executable targets found or failed to get build directory.")
              return
                end

-- Assuming you have already set up dap
  -- local dap = require('dap')
    dap.configurations.swift = {}

        for _, target in ipairs(targets) do
              local argsString = vim.fn.input('Command line args for ' .. target .. ': ')
        -- Split the argsString into a table of arguments
        local args = {}
            for arg in argsString:gmatch("%S+") do table.insert(args, arg) end

            table.insert(dap.configurations.swift, {
              type = "codelldb",
              request = "launch",
              name = "Debug " .. target,
              program = buildDir .. "/" .. target,
              args = args,
                                              })
                                                end
                                                end
return M
