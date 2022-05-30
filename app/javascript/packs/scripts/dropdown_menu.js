
   
document.addEventListener('DOMContentLoaded', () => {

  const dropdownToggle = document.querySelector('.dropdown-toggle');
  const dropdownMenu = document.querySelector('.dropdown-menu');
  let shown = 0;
  
  if(dropdownToggle) {
    dropdownToggle.addEventListener('click', (e) => { toggleDropdown(e) })
  }

  function toggleDropdown(e) {
    e.preventDefault()
    dropdownMenu.classList.toggle('show')
    shown = 1;

    shown == 0 ? dropdownToggle.setAttribute('aria-expanded', 'false') : dropdownToggle.setAttribute('aria-expanded', 'true')
  }

});
