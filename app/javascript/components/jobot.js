import $ from 'jquery'

const botScript = (e) => {
  if (e.key === 'Enter' || e.type === 'click') {
    if (e.key === 'Enter') {
      e.preventDefault()
    }
    const div = e.currentTarget.closest('.bot-div')
    const nextDiv = div.nextElementSibling
    $('.select2-container--open').remove()
    if (!nextDiv) {
      return
    }
    const nextInputs = nextDiv.querySelectorAll('.bot-input')
    nextDiv.removeAttribute('hidden')
    div.setAttribute('hidden', true)
    nextInputs.forEach(nextInput => {
      if (nextInput.type === 'text') {
        nextInput.addEventListener('keydown', botScript)
      } else if (nextInput.type === 'radio') {
        nextInput.addEventListener('click', botScript)
      } else if (nextInput.type === 'select-multiple') {
        nextInput.parentNode.addEventListener('keydown', botScript)
      }
    })
    if(div.id === 'bot-start') {
      const name = e.currentTarget.value
      nextDiv.firstElementChild.innerHTML = `<h5>Ok ${name}, what job titles are you looking for</h5>`
    } else if (div.id === 'bot-location') {
      const location = e.currentTarget.value
      nextDiv.firstElementChild.innerHTML = `<h5>Do you need a visa to work in ${location}?</h5>`
    }
  }
}

if (document.getElementById('bot-start')) {
  document.getElementById('bot-start').querySelector('input').addEventListener('keydown', botScript)
}
