// Drag-and-drop reordering for ActiveAdmin has_many nested forms.
// Requires SortableJS (loaded from CDN via register_javascript).
//
// Strategy: for each .has_many_container, attach Sortable to the inner OL.
// On drop, renumber the [position] input in each row to its new index.
// The parent form save persists the new order.

(function () {
  function initSortableHasMany() {
    if (typeof Sortable === "undefined") return;

    document.querySelectorAll(".has_many_container").forEach(function (container) {
      if (container.dataset.sortableInit === "true") return;
      container.dataset.sortableInit = "true";

      // ActiveAdmin renders each row as <li class="has_many_fields"> inside an OL.
      // The "add" button is a sibling <li> we must NOT make draggable.
      var list = container.querySelector("ol");
      if (!list) return;
      if (!list.querySelector(".has_many_fields")) return;

      // Add a drag-handle hint and a visual cue to each row's legend.
      list.querySelectorAll(".has_many_fields").forEach(function (row, idx) {
        var legend = row.querySelector("legend");
        if (legend && !legend.classList.contains("sortable-handle")) {
          legend.classList.add("sortable-handle");
          legend.title = "Drag to reorder";
        }
      });

      Sortable.create(list, {
        animation: 150,
        draggable: ".has_many_fields",
        handle: ".sortable-handle",
        ghostClass: "sortable-ghost",
        chosenClass: "sortable-chosen",
        dragClass: "sortable-drag",
        onEnd: function () {
          var rows = list.querySelectorAll(".has_many_fields");
          rows.forEach(function (row, idx) {
            var posInput = row.querySelector('input[name$="[position]"]');
            if (posInput) {
              posInput.value = idx;
              // Briefly flash the field so the user sees the number change
              posInput.style.transition = "background-color 0.4s";
              posInput.style.backgroundColor = "#fff9d6";
              setTimeout(function () { posInput.style.backgroundColor = ""; }, 600);
            }
          });
        }
      });
    });
  }

  // Run after the page loads. Cover both classic and Turbo navigation.
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initSortableHasMany);
  } else {
    initSortableHasMany();
  }
  document.addEventListener("turbo:load", initSortableHasMany);

  // Re-init when ActiveAdmin clones a row via "+ Add" button.
  document.addEventListener("click", function (e) {
    if (e.target && e.target.matches(".has_many_add a, .has_many_add")) {
      // Defer until the DOM is updated
      setTimeout(initSortableHasMany, 50);
    }
  });
})();
