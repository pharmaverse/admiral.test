#' An example function as expected by the `get_smq_fun` parameter of
#' `admiral::create_query_data()`
#'
#' @param smq_select An smq_select object defining the terms
#'
#' @param version MedDRA version
#'
#' @param keep_id Should `QUERY_ID` be included in the output?
#'
#' @param temp_env Temporary environment
get_smq_terms <- function(smq_select,
                          version,
                          keep_id,
                          temp_env) {
  if (is.null(temp_env$smq_db)) {
    data("smq_db", envir = temp_env)
  }
  if (!is.null(smq_select$name)) {
    cond_smq <- expr(smq_name == !!smq_select$name)
  } else {
    cond_smq <- expr(smq_id == !!smq_select$id)
  }
  if (smq_select$scope == "NARROW") {
    cond_scope <- expr(scope == "narrow")
  } else {
    cond_scope <- TRUE
  }
  if (keep_id) {
    select_id <- exprs(QUERY_ID = smq_id)
  } else {
    select_id <- NULL
  }

  temp_env$smq_db %>%
    filter(version == version, !!cond_smq, !!cond_scope) %>%
    transmute(TERM_NAME = termname, TERM_LEVEL = termvar, QUERY_NAME = smq_name, !!!select_id)
}

#' An example function as expected by the `get_smq_fun` parameter of
#' `admiral::create_query_data()`
#'
#' @param sdg_select An sdg_select object defining the terms
#'
#' @param version SDG version
#'
#' @param keep_id Should `QUERY_ID` be included in the output?
#'
#' @param temp_env Temporary environment
get_sdg_terms <- function(sdg_select,
                          version,
                          keep_id,
                          temp_env) {
  if (is.null(temp_env$sdg_db)) {
    data("sdg_db", envir = temp_env)
  }
  if (!is.null(sdg_select$name)) {
    cond <- expr(sdg_name == !!sdg_select$name)
  } else {
    cond <- expr(sdg_id == !!sdg_select$id)
  }
  if (keep_id) {
    select_id <- exprs(QUERY_ID = sdg_id)
  } else {
    select_id <- NULL
  }

  temp_env$sdg_db %>%
    filter(version == version, !!cond) %>%
    transmute(TERM_NAME = termname, TERM_LEVEL = termvar, QUERY_NAME = sdg_name, !!!select_id)
}
