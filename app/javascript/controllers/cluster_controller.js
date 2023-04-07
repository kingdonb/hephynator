import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['lightup']

  create() {
    this.lightupTarget.submit()
  }

  kubeconfig() {
    let href = window.location.href + '/kubeconfig'
    window.location.replace(href);
  }

  connect() {
  }
}
