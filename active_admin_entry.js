
window.require = function(mod) {
  if (mod === "jquery") return window.jQuery;
  return {};
};
import "@activeadmin/activeadmin";

