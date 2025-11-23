import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["template"];

	connect() {
		this.element[this.identifier] = this;
		console.log("Clone controller connected", this.templateTarget);
	}

	insert(event) {
		event.preventDefault();
		event.stopPropagation();

		try {
			if (!this.templateTarget) {
				console.error("Template target not found");
				return;
			}

			const content = this.templateTarget.innerHTML;
			const button = event.currentTarget;
			button.insertAdjacentHTML("beforebegin", content);

			// The newly inserted element will be right before the current target
			const insertedElement = button.previousElementSibling;
			if (insertedElement) {
				const input = insertedElement.querySelector("input");
				if (input) input.focus();
			}
		} catch (error) {
			console.error("Error in clone#insert:", error);
		}
	}
}


