    const totalPosts = 2000;
    const postsPerPage = 15;
    const totalPages = Math.ceil(totalPosts / postsPerPage);

    let currentPage = 1;

    function getPostsForPage(page) {
        const posts = [];
        const start = (page - 1) * postsPerPage + 1;
        const end = Math.min(page * postsPerPage, totalPosts);
        for (let i = start; i <= end; i++) {
            posts.push({
                number: i,
                title: '게시물 제목 ' + i,
                author: '작성자' + ((i % 5) + 1),
                date: '2025-06-18',
                views: Math.floor(Math.random() * 1000),
                recommend: Math.floor(Math.random() * 100),
            });
        }
        return posts;
    }

    function renderPosts(page) {
        $('#title_container').find('.cv').remove();
        const posts = getPostsForPage(page);
        posts.forEach(post => {
            const cv = $('<div class="cv"></div>');
            cv.append(`<div>${post.number}</div>`);
            cv.append(`<div>${post.title}</div>`);
            cv.append(`<div>${post.author}</div>`);
            cv.append(`<div>${post.date}</div>`);
            cv.append(`<div>${post.views}</div>`);
            cv.append(`<div>${post.recommend}</div>`);
            $('#title_container').append(cv);
        });
    }

    function renderPageControls(page) {
        $('.page_controls').remove();
        const pageControls = $('<div class="page_controls"></div>');

        if (page > 1) {
            pageControls.append('<div class="page_prev" style="cursor:pointer;">이전</div>');
        }

        let startPage, endPage;
        if (totalPages <= 5) {
            startPage = 1;
            endPage = totalPages;
        } else if (page === 1 || page === 2) {
            startPage = 1;
            endPage = 3;
        } else if (page === totalPages || page === totalPages-1) {
            startPage = totalPages - 5;
            endPage = totalPages;
        } else {
            startPage = page - 2;
            endPage = page + 2;
        }

        for (let i = startPage; i <= endPage; i++) {
            const pageDiv = $('<div class="page_idx" style="cursor:pointer; display:inline-block; margin:0 5px;"></div>').text(i);
            if (i === page) {
                pageDiv.css({ 'font-weight': 'bold', 'text-decoration': 'underline' });
            }
            pageControls.append(pageDiv);
        }

        if (page < totalPages) {
            pageControls.append('<div class="page_next" style="cursor:pointer;">다음</div>');
        }

        $('#board_container > div').append(pageControls);

        $('.page_prev').off('click').on('click', () => {
            if (currentPage-10 >= 1) {
                renderAll(currentPage - 10);
            }
            else renderAll(1);
        });

        $('.page_next').off('click').on('click', () => {
            if (currentPage+10 <= totalPages) {
                renderAll(currentPage + 10);
            }
            else renderAll(totalPages);
        });

        $('.page_idx').off('click').on('click', function () {
            const pageClicked = parseInt($(this).text());
            if (pageClicked !== currentPage) {
                renderAll(pageClicked);
            }
        });
    }

    function renderAll(page) {
        currentPage = page;
        renderPosts(page);
        renderPageControls(page);
    }

    $(function () {
        renderAll(1);
    });
