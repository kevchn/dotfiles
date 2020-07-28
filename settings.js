{
    // Go Autocomplete, Linting, etc =======================
    "go.formatTool": "goimports",
    "go.useLanguageServer": true,
    "[go]": {
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.organizeImports": true,
        },
        // Optional: Disable snippets, as they conflict with completion ranking.
        "editor.snippetSuggestions": "none",
    },
    "gopls": {
        // Add parameter placeholders when completing a function.
        "usePlaceholders": true,
        // If true, enable additional analyses with staticcheck.
        // Warning: This will significantly increase memory usage.
        "staticcheck": false,
    },
    "files.eol": "\n",
    "timeline.excludeSources": [],
    // golangci-lint integrations
    "go.lintTool": "golangci-lint",
    "go.lintFlags": [
        "--fast"
    ],
    // Git diffs ===========================================
    // Maximize new window (for git difftool)
    "window.newWindowDimensions": "maximized",
    // Git: Ignore warning if there are too many git changes
    "git.ignoreLimitWarning": true,
}