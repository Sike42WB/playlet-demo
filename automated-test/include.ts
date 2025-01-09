import { device, utils } from "roku-test-automation";

exports.mochaHooks = {
    async beforeAll() {

        utils.setupEnvironmentFromConfigFile('./rta-config.json');
        console.log('deploying app');
        await device.deploy(
            {
                rootDir: "./build/playlet-app",
                files: ["**/*"]
            }
        );
    }
};
