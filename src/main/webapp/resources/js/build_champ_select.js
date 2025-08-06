/**
 * 
 */
window.addEventListener('DOMContentLoaded', () => {
  const selectBox = document.getElementById('select-box');
  const champ_Container = document.getElementById('champ_container');

  // nullcontainer 위치와 높이 구하기
  function updateChatPosition() {
    const containerRect = champ_Container.getBoundingClientRect();
    const containerTop = window.scrollY + containerRect.top;
    const containerBottom = containerTop + champ_Container.offsetHeight;

    const scrollY = window.scrollY;
    const fixedTop = 100; // 화면 상단 고정 위치

    if (scrollY + fixedTop < containerTop) {
      // 아직 container 위에 있을 때
      selectBox.classList.remove('fixed', 'stuck-bottom');
      selectBox.style.position = 'absolute';
      selectBox.style.top = '0';
      selectBox.style.right = '0';
    } else if (scrollY + fixedTop >= containerTop && scrollY + fixedTop + selectBox.offsetHeight < containerBottom) {
      // container 범위 내에서 고정
      selectBox.classList.add('fixed');
      selectBox.classList.remove('stuck-bottom');
    } else {
      // container 아래쪽에 도달하면 하단에 고정
      selectBox.classList.remove('fixed');
      selectBox.classList.add('stuck-bottom');
    }
  }

  window.addEventListener('scroll', updateChatPosition);
  window.addEventListener('resize', updateChatPosition);

  updateChatPosition(); // 초기 위치 설정
});