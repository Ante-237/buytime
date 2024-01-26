const paymentForm = document.getElementById("paymentForm")
paymentForm.addEventListener("submit", payWithPaystack, false)

function payWithPaystack(e) {
	e.preventDefault()

	let handler = PaystackPop.setup({
		key: "pk_test_12cdb59555518276fd67f35ad04ac1e176485b0c",
		email: document.getElementById("email-address").value,
		amount: document.getElementById("amount").value * 100,
		currency: "NGN",
		onClose: function () {
			alert("Window closed.")
		},
		callback: function (response) {
			let message = "Payment complete! Reference: " + response.reference
			alert(message)

			// Reset the form after successful payment
			resetForm()
		},
	})

	handler.openIframe()
}

function resetForm() {
	// Get the form element
	const form = document.getElementById("paymentForm")

	// Reset the form fields
	form.reset()
}
