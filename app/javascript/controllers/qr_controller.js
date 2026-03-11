import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    
  connect() {
    console.log("qr-controller connected")
  }
    
  download(event) {
  const shortCode = event.currentTarget.dataset.shortCode
  console.log("shortCode:", shortCode)
  fetch(`/qr_download?short_code=${shortCode}`)
    .then(res => {
      console.log("response status:", res.status)
      return res.blob()
    })
    .then(blob => {
      console.log("blob size:", blob.size)
      const url = URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = `${shortCode}_qrcode.png`
      document.body.appendChild(a)
      a.click()
      document.body.removeChild(a)
      setTimeout(() => URL.revokeObjectURL(url), 100)
    })
    .catch(err => console.error("fetch error:", err))
  }
}