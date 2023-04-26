import { setFailed } from "@actions/core";
import { processAnnotations } from "./annotate";
import { exportStepSummary } from "./utils";

// This is the entrypoint of the javascript app that processes the json files
// from steampipe check and pushes the summary for the job and also the
// annotations.
//
// This app is executed with the list of checks from the input of the action
// as separate arguments in the argument vector
async function run() {
  try {
    let token = process.env["GITHUB_TOKEN"];
    if (token.trim().length == 0) {
      throw new Error("Error: github token is required but was not supplied");
    }
    // start from the third element in the argument vector, since the first two are
    // the path to the node executable and the path to the js file
    let runs = process.argv.slice(2);
    await processAnnotations({ token, runs });
    await exportStepSummary({ token, runs });
  } catch (error) {
    setFailed(error.message);
  }
}

run();
