local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local conds = require("luasnip.extras.expand_conditions")

return {
  s(
    {
      trig = "b",
      name = "build",
      dscr = "changes that affect the build system or external dependencies",
    },
    fmt("build{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "ch",
      name = "chore",
      dscr = "changes that do not relate to a fix or feature and don't modify src or test files",
    },
    fmt("chore{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "ci",
      name = "ci",
      dscr = "changes to Continuous Integration configuration files and scripts",
    },
    fmt("ci{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "d",
      name = "docs",
      dscr = "updates to documentation such as README, CONTRIBUTING, etc.",
    },
    fmt("docs{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "f",
      name = "feat",
      dscr = "changes that introduces a new feature",
    },
    fmt("feat{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "fi",
      name = "fix",
      dscr = "changes that includes a bug fix",
    },
    fmt("fix{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "p",
      name = "perf",
      dscr = "changes that has performance improvements",
    },
    fmt("perf{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "r",
      name = "refactor",
      dscr = "changes that related to code refactor that neither fixes a bug nor adds a feature",
    },
    fmt("refactor{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "rev",
      name = "revert",
      dscr = "reverts a previous commit",
    },
    fmt("revert{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "s",
      name = "style",
      dscr = "changes that doesn't affect the meaning of the code",
    },
    fmt("style{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = "t",
      name = "test",
      dscr = "changes that are related to test cases like adding new test cases or modifying existing test cases",
    },
    fmt("test{}: {}\n\n{}", {
      i(1, ""),
      i(2, ""),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
}
