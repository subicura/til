# 뒤로가기 캐시버그

잠깐 고생한 버그인데..

Rails에서는 동일한 URL에 accept, content-type header에 따라 HTML/JSON/XML을 내려줄 수가 있다.

리스트 페이징을 ajax로 처리하는 경우 동일한 URL 형식에 header를 바꿔서 요청하곤 했는데 이게 history.pushstate와 결합하면서 버그가 생김.

/projects?page=1 에서 /projects?page=2를 pushstate하면서 /projects?page=2 (application/json header)를 ajax로 요청하여 화면에 데이터를 바인딩 했는데, 거기서 /projects/10 이라는 페이지로 이동(not pushstate, 실제로 페이지 이동)했다가 뒤로가기 버튼을 누르게 되면 /projects?page=2에 요청했던 data를 cache로 바로 로딩한다.

뒤로가기 자체가 보통 새로고침을 할필요 없이 전에 봤던 페이지가 나오면 되기 때문에 캐싱을 읽은건데 문제는 json response가 나온다.

딱히 방법은 없는것 같고 ajax 호출시 header방식대신 url에 명시적으로 .json을 추가하는 방식(/projects.json?page=2)으로 해결함
