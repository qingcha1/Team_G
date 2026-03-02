# AGENTS.md

## Cursor Cloud specific instructions

### Project overview

This is a blockchain-based Employee Payroll System teaching project (智能合约开发课程). The repo contains multiple independent lesson directories under `projects/`. The most complete and working project is `projects/lesson-5-solution` (reference implementation). See the root `README.md` for general info.

### Runtime requirements

- **Node.js 9.4.0** via nvm (`nvm use 9.4.0`). The project uses legacy Solidity 0.4.17 and old React/Webpack tooling that requires this specific Node version.
- **Truffle v4.1.17** (global). The latest truffle uses optional chaining syntax unsupported by Node 9.x; always pin to v4.
- **Ganache CLI** (global). Local Ethereum blockchain simulator.
- **Python 3** symlinked as `/usr/bin/python` for node-gyp native module builds.

### Known issues

- `projects/lesson-6/src/components/Employee.js` has leftover diff markers (`+` at line starts in lines 47-52) causing compilation failure. Use `lesson-5-solution` as the working reference implementation instead.
- `projects/lesson-4/` is an incomplete homework assignment (missing `Payroll.sol` contract); its tests cannot run.
- `npm install` in lesson projects will fail on `node-sass@3.13.1` native build. Use `npm install --ignore-scripts` then `npm rebuild secp256k1 keccak` to install only the needed native modules.

### How to run (lesson-5-solution)

Standard workflow documented in lesson READMEs:

1. `ganache-cli -a 20 -e 1000 --host 0.0.0.0` (background, port 8545)
2. `cd projects/lesson-5-solution && truffle compile && truffle migrate --reset`
3. `HOST=0.0.0.0 BROWSER=none npm run start` (port 3000)

### Lint / Test / Build

- **Lint:** `cd projects/lesson-5-solution && npx eslint src/` (ESLint 3.x with react-app config)
- **Test:** Truffle tests in lesson-4 are non-functional (missing contract). The lesson-5-solution test files reference `SimpleStorage.sol` which is a placeholder from `truffle unbox react`.
- **Build:** `cd projects/lesson-5-solution && npm run build`
