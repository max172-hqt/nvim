return function()
  local gl = require('galaxyline')
  local colors = require('galaxyline.theme').default
  local condition = require('galaxyline.condition')
  local utils = require('modules.ui.utils')
  local gls = gl.section
  gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

  gls.left[1] = {
    RainbowRed = {
      provider = function()
        return '▊ '
      end,
      highlight = {colors.blue, colors.bg}
    }
  }
  gls.left[2] = {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red
        }
        local color = mode_color[vim.fn.mode()] or colors.violet
        local aliases = {
          [110] = 'N',
          [105] = 'I',
          [99] = 'C',
          [116] = 'T',
          [118] = 'V',
          [22] = 'Vb',
          [86] = 'Vl',
          [82] = 'Re',
          [115] = 'SELECT',
          [83] = 'S-LINE'
        }
        vim.api.nvim_command('hi GalaxyViMode guibg=' .. color)
        local alias = aliases[vim.fn.mode():byte()]
        local mode
        if alias ~= nil then
          if utils.has_width_gt(35) then
            mode = alias
          else
            mode = alias:sub(1, 1)
          end
        else
          mode = vim.fn.mode():byte()
        end
        return '  ' .. mode .. ' '
      end,
      highlight = {colors.bg, colors.bg, 'bold'},
      separator = ' ',
    }
  }
  -- gls.left[3] = {
  --   FileSize = {
  --     provider = 'FileSize',
  --     condition = condition.buffer_not_empty,
  --     highlight = {colors.fg,colors.bg}
  --   }
  -- }
  gls.left[4] = {
    FileIcon = {
      separator = ' ',
      provider = 'FileIcon',
      condition = condition.buffer_not_empty,
      highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg}
    }
  }

  gls.left[5] = {
    FileName = {
      provider = 'FileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.fg, colors.bg, 'bold'}
    }
  }

  -- gls.left[6] = {
  --   LineInfo = {
  --     provider = 'LineColumn',
  --     separator = ' ',
  --     separator_highlight = {'NONE',colors.bg},
  --     highlight = {colors.fg,colors.bg},
  --   },
  -- }

  -- gls.left[7] = {
  --   PerCent = {
  --     provider = 'LinePercent',
  --     separator = ' ',
  --     separator_highlight = {'NONE',colors.bg},
  --     highlight = {colors.fg,colors.bg,'bold'},
  --   }
  -- }

  gls.left[8] = {
    DiagnosticError = {
      provider = 'DiagnosticError',
      separator = ' ',
      icon = 'E:',
      highlight = {colors.red, colors.bg}
    }
  }
  gls.left[9] = {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      separator = ' ',
      icon = 'W:',
      highlight = {colors.yellow, colors.bg}
    }
  }

  gls.left[10] = {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      separator = ' ',
      icon = 'I:',
      highlight = {colors.blue, colors.bg}
    }
  }

  gls.left[11] = {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = 'H:',
      highlight = {colors.cyan, colors.bg}
    }
  }

  -- gls.right[1] = {
  --   ShowLspClient = {
  --     provider = 'GetLspClient',
  --     condition = function()
  --       local tbl = {
  --         ['dashboard'] = true,
  --         [''] = true
  --       }
  --       if tbl[vim.bo.filetype] then
  --         return false
  --       end
  --       return true
  --     end,
  --     icon = '',
  --     highlight = {colors.yellow,colors.bg,'bold'}
  --   }
  -- }

  -- gls.right[1] = {
  --   FileEncode = {
  --     provider = 'FileEncode',
  --     condition = condition.hide_in_width,
  --     separator = ' ',
  --     separator_highlight = {'NONE',colors.bg},
  --     highlight = {colors.green,colors.bg,'bold'}
  --   }
  -- }

  -- gls.right[2] = {
  --   FileFormat = {
  --     provider = 'FileFormat',
  --     condition = condition.hide_in_width,
  --     separator = ' ',
  --     separator_highlight = {'NONE',colors.bg},
  --     highlight = {colors.green,colors.bg,'bold'}
  --   }
  -- }

  gls.right[3] = {
    GitIcon = {
      provider = function()
        return '  '
      end,
      condition = condition.check_git_workspace,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.violet, colors.bg, 'bold'}
    }
  }

  gls.right[4] = {
    GitBranch = {
      provider = 'GitBranch',
      condition = condition.check_git_workspace,
      highlight = {colors.violet, colors.bg, 'bold'}
    }
  }

  gls.right[5] = {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = condition.hide_in_width,
      separator = ' ',
      icon = '+',
      highlight = {colors.green, colors.bg}
    }
  }
  gls.right[6] = {
    DiffModified = {
      provider = 'DiffModified',
      condition = condition.hide_in_width,
      icon = '~',
      highlight = {colors.orange, colors.bg}
    }
  }
  gls.right[7] = {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = condition.hide_in_width,
      icon = '-',
      highlight = {colors.red, colors.bg}
    }
  }

  gls.right[8] = {
    LineInfo = {
      provider = 'LineColumn',
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.fg, colors.bg}
    }
  }

  gls.right[9] = {
    PerCent = {
      provider = 'LinePercent',
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.fg, colors.bg, 'bold'}
    }
  }

  gls.right[10] = {
    RainbowBlue = {
      provider = function()
        return ' ▊'
      end,
      highlight = {colors.blue, colors.bg}
    }
  }

  gls.short_line_left[1] = {
    BufferType = {
      provider = 'FileTypeName',
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.blue, colors.bg, 'bold'}
    }
  }

  gls.short_line_left[2] = {
    SFileName = {
      provider = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.fg, colors.bg, 'bold'}
    }
  }

  gls.short_line_right[1] = {
    BufferIcon = {
      provider = 'BufferIcon',
      highlight = {colors.fg, colors.bg}
    }
  }

end
