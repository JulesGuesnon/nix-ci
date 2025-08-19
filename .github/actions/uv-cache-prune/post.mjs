import { execSync } from "node:child_process";

execSync("uv cache prune --ci", { stdio: "inherit" });
