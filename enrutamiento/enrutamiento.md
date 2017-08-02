---
layout: page
title: ENRUTADORES
permalink: /enrutadores/
---

<div class="home">

  <ul class="posts">
    {% for post in site.posts %}
    {% if post.categories contains 'teldat' or post.tags contains 'router' or  post.categories contains 'cisco' or  post.categories contains 'juniper' or  post.categories contains 'router'%}
      <li>
        <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
      </li>
    {% endif %}
    {% endfor %}
  </ul>

</div>
