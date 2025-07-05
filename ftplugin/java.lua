local home = os.getenv 'HOME'
local jdtls_path = home .. '/.local/share/nvim/mason/packages/jdtls'

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
    vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    jdtls_path .. '/config_linux',
    '-data',
    home .. '/.cache/jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
  },

  settings = {
    java = {
      implementationsCodeLens = { enabled = true },
    },
  },
  root_dir = require('jdtls.setup').find_root { 'gradlew', '.git', 'mvnw' },
}

require('jdtls').start_or_attach(config)
