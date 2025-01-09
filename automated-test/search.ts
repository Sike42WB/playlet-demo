import { ecp, odc, utils } from "roku-test-automation";
import * as chai from 'chai';
const expect = chai.expect;

describe('Search', async () => {
    it('should be able to find and play a video from scratch ', async () => {
        await utils.sleep(10000);
        await ecp.sendKeypress(ecp.Key.Ok);
        await ecp.sendKeypress(ecp.Key.Left);
        await ecp.sendKeypress(ecp.Key.Up);
        await ecp.sendKeypress(ecp.Key.Ok);
        await ecp.sendKeypress(ecp.Key.Right);
        await ecp.sendKeypress(ecp.Key.Down);



    });
});