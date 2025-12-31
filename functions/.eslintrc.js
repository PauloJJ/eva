module.exports = {
    env: {
        es6: true,
        node: true,
    },
    parserOptions: {
        ecmaVersion: 2018,
    },
    extends: [
        "eslint:recommended",
        "google",
    ],
    rules: {
        "no-restricted-globals": ["error", "name", "length"],
        "prefer-arrow-callback": "error",
        "quotes": ["error", "double", { "allowTemplateLiterals": true }],
        "object-curly-spacing": ["error", "always"],
        "indent": ["error", 4],
        "max-len": "off",
        "padded-blocks": "off",
    },
    overrides: [
        {
            files: [".eslintrc.js"],
            rules: {
                "indent": "off",
            },
        },
        {
            files: ["**/*.spec.*"],
            env: {
                mocha: true,
            },
            rules: {},
        },
    ],
    globals: {},
};
