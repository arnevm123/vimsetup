require('refactoring').setup({
  -- overriding printf statement for cpp
  print_var_statements = {
      -- add a custom print var statement for cpp
      ts = {
          'console.log(%s)'
      },
      js = {
          'console.log(%s)'
      }
  }
})
