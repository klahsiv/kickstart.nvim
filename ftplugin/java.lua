local home = vim.fn.expand '~'
local jdtls_path = home .. '/.local/share/nvim/mason/packages/jdtls'
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local workspace_dir = home .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local config = {
  cmd = {
    '/usr/lib/jvm/java-21-openjdk-amd64/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    launcher_jar,
    '-configuration',
    jdtls_path .. '/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root {
    '.git',
    'mvnw',
    'gradlew',
    'pom.xml',
    'build.gradle',
  },
  settings = {
    java = {
      imports = {
        gradle = {
          wrapper = {
            checksums = {
              {
                sha256 = '7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172',
                allowed = true,
              },
            },
          },
        },
      },
    },
  },
}

require('jdtls').start_or_attach(config)
