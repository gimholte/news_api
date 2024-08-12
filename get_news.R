library(httr2)

readRenviron('.Renviron')

req <- request("https://newsapi.org/v2/everything") |>
  req_url_query(
    q = '`"data science"`',
    from = Sys.Date() - 1,
    pageSize = 10,
    apiKey = Sys.getenv("NEWS_API_KEY")
  )

resp <- req_perform(req)

output_file_date <- lubridate::today() |> format('%Y-%m-%d')
output_filename <- paste0("./data/", output_file_date, '.json')
resp_body_json(resp) |> jsonlite::write_json(output_filename)
