var __defProp = Object.defineProperty;
var __defNormalProp = (obj, key, value) => key in obj ? __defProp(obj, key, { enumerable: true, configurable: true, writable: true, value }) : obj[key] = value;
var __publicField = (obj, key, value) => {
  __defNormalProp(obj, typeof key !== "symbol" ? key + "" : key, value);
  return value;
};
var __accessCheck = (obj, member, msg) => {
  if (!member.has(obj))
    throw TypeError("Cannot " + msg);
};
var __privateGet = (obj, member, getter) => {
  __accessCheck(obj, member, "read from private field");
  return getter ? getter.call(obj) : member.get(obj);
};
var __privateAdd = (obj, member, value) => {
  if (member.has(obj))
    throw TypeError("Cannot add the same private member more than once");
  member instanceof WeakSet ? member.add(obj) : member.set(obj, value);
};
var __privateSet = (obj, member, value, setter) => {
  __accessCheck(obj, member, "write to private field");
  setter ? setter.call(obj, value) : member.set(obj, value);
  return value;
};
var __privateMethod = (obj, member, method) => {
  __accessCheck(obj, member, "access private method");
  return method;
};
var _offscreenCanvas, _OffscreenWorker, _initScene, initScene_fn;
const blob = typeof window !== "undefined" && window.Blob && new Blob([atob(encodedJs)], { type: "text/javascript;charset=utf-8" });
function WorkerWrapper() {
  const objURL = blob && (window.URL || window.webkitURL).createObjectURL(blob);
  try {
    return objURL ? new Worker(objURL, {}) : new Worker("data:application/javascript;base64," + encodedJs, { type: "module" });
  } finally {
    objURL && (window.URL || window.webkitURL).revokeObjectURL(objURL);
  }
}
class WorldOffScreen {
  constructor(options) {
    __privateAdd(this, _initScene);
    __publicField(this, "initialized", false);
    __publicField(this, "offscreenWorkerInit", false);
    __publicField(this, "themeLoadedInit", false);
    __publicField(this, "pendingThemePromises", {});
    __privateAdd(this, _offscreenCanvas, void 0);
    __privateAdd(this, _OffscreenWorker, void 0);
    __publicField(this, "onRollResult", () => {
    });
    __publicField(this, "onRollComplete", () => {
    });
    this.onInitComplete = options.onInitComplete;
    __privateSet(this, _offscreenCanvas, options.canvas.transferControlToOffscreen());
    __privateSet(this, _OffscreenWorker, new WorkerWrapper());
    __privateGet(this, _OffscreenWorker).init = new Promise((resolve, reject) => {
      this.offscreenWorkerInit = resolve;
    });
    this.initialized = __privateMethod(this, _initScene, initScene_fn).call(this, options);
  }
  connect(port) {
    __privateGet(this, _OffscreenWorker).postMessage({
      action: "connect",
      port
    }, [port]);
  }
  updateConfig(options) {
    __privateGet(this, _OffscreenWorker).postMessage({ action: "updateConfig", options });
  }
  resize(options) {
    __privateGet(this, _OffscreenWorker).postMessage({ action: "resize", options });
  }
  async loadTheme(options) {
    return new Promise((resolve, reject) => {
      if (Object.keys(this.pendingThemePromises).includes(options.theme)) {
        return resolve();
      }
      this.pendingThemePromises[options.theme] = resolve;
      __privateGet(this, _OffscreenWorker).postMessage({ action: "loadTheme", options });
    }).catch((error) => console.error(error));
  }
  clear() {
    __privateGet(this, _OffscreenWorker).postMessage({ action: "clearDice" });
  }
  add(options) {
    __privateGet(this, _OffscreenWorker).postMessage({ action: "addDie", options });
  }
  addNonDie(options) {
    __privateGet(this, _OffscreenWorker).postMessage({ action: "addNonDie", options });
  }
  remove(options) {
    __privateGet(this, _OffscreenWorker).postMessage({ action: "removeDie", options });
  }
}
_offscreenCanvas = new WeakMap();
_OffscreenWorker = new WeakMap();
_initScene = new WeakSet();
initScene_fn = async function(config) {
  __privateGet(this, _OffscreenWorker).postMessage({
    action: "init",
    canvas: __privateGet(this, _offscreenCanvas),
    width: config.canvas.clientWidth,
    height: config.canvas.clientHeight,
    options: config.options
  }, [__privateGet(this, _offscreenCanvas)]);
  __privateGet(this, _OffscreenWorker).onmessage = (e) => {
    switch (e.data.action) {
      case "init-complete":
        this.offscreenWorkerInit();
        break;
      case "connect-complete":
        break;
      case "theme-loaded":
        if (e.data.id) {
          this.pendingThemePromises[e.data.id](e.data.id);
        }
        break;
      case "roll-result":
        this.onRollResult(e.data.die);
        break;
      case "roll-complete":
        this.onRollComplete();
        break;
      case "die-removed":
        this.onDieRemoved(e.data.rollId);
        break;
    }
  };
  await __privateGet(this, _OffscreenWorker).init;
  this.onInitComplete(true);
  return true;
};
export { WorldOffScreen as default };