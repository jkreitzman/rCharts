dTable <- dataTable <- function(x, ...){
  myTable <- Datatables$new()
  myTable$addTable( x, ... )
  return(myTable$copy())
}

Datatables = setRefClass('Datatables', contains = 'rCharts', methods = list(
  initialize = function(x){
    callSuper()
    container <<- 'table'
  },
  addTable = function(x, ...){
    params$table <<- modifyList(make_table2(x), list(...))
  },
  getPayload = function(chartId){
    list(chartParams = toJSON2(params), chartId = chartId, lib = basename(lib))
  }
))

make_table <- function(df){
  nms = names(df)
  nms = setNames(nms, rep('title', length(nms)))
  l = apply(setNames(df, NULL), 1, as.list)
  names(l) = NULL
  list(data = l, columns = nms)
}


make_table2 <- function(df_){
  nms = names(df_)
  nms = lapply(nms, function(nm){
    list(title = nm)
  })
  list(
    data = toJSONArray2(df_, json = F, names = F),
    columns = as.list(nms)
  )
}
