import globals from "globals";
import pluginJs from "@eslint/js";
import eslintConfigPrettier from "eslint-config-prettier";

/** @type {import('eslint').Linter.Config[]} */
export default [
  {
    languageOptions: {
      globals: { ...globals.browser, ...globals.node, bootstrap: "readonly" },
    },
  },
  pluginJs.configs.recommended,
  eslintConfigPrettier,
];
