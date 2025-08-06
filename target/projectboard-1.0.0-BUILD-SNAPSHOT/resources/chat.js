/**
 * 
 */
window.addEventListener('DOMContentLoaded', () => {
  const chatBox = document.getElementById('chat-box');
  const chat_Container = document.getElementById('chat_container');

  // nullcontainer 위치와 높이 구하기
  function updateChatPosition() {
    const containerRect = chat_Container.getBoundingClientRect();
    const containerTop = window.scrollY + containerRect.top;
    const containerBottom = containerTop + chat_Container.offsetHeight;

    const scrollY = window.scrollY;
    const fixedTop = 100; // 화면 상단 고정 위치

    if (scrollY + fixedTop < containerTop) {
      // 아직 container 위에 있을 때
      chatBox.classList.remove('fixed', 'stuck-bottom');
      chatBox.style.position = 'absolute';
      chatBox.style.top = '0';
      chatBox.style.right = '0';
    } else if (scrollY + fixedTop >= containerTop && scrollY + fixedTop + chatBox.offsetHeight < containerBottom) {
      // container 범위 내에서 고정
      chatBox.classList.add('fixed');
      chatBox.classList.remove('stuck-bottom');
    } else {
      // container 아래쪽에 도달하면 하단에 고정
      chatBox.classList.remove('fixed');
      chatBox.classList.add('stuck-bottom');
    }
  }

  window.addEventListener('scroll', updateChatPosition);
  window.addEventListener('resize', updateChatPosition);

  updateChatPosition(); // 초기 위치 설정
});