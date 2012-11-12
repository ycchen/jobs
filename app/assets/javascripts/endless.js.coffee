  jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next > a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
        $('.pagination').text("Fetching more jobs...")
        $.getScript(url)
    $(window).scroll