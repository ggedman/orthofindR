
#' getOrthologs 
#' 
#' Get all one-to-one orthologs between a given species and a desired species 
#' 
#' @import biomaRt
#' @param input_org Species you are starting from. This should be in the latin name format. i.e. Human, Homo Sapien should be "hsapiens"
#' @param output_org Species you want to know the orthologs in. Same format as input_org.  
#' @param one2one Specifies if one-2-one orthology is perferred. If set to TRUE, will only return orthology for one-2-one orthologs
#' @return data frame with all one-to-one orthologs between specified species 
#' @export
getOrthos <- function(input_org,output_org,one2one) {
  tmp_input <- paste(input_org,"_gene_ensembl",sep = "")
  tmp_mart <- useMart("ensembl", dataset = tmp_input) 
  tmp_attr <- listAttributes(tmp_mart)
  tmp_genes <- getBM(attributes = c("ensembl_gene_id", "gene_biotype"), mart = tmp_mart)
  tmp_genes <- tmp_genes[grep("protein_coding",tmp_genes$gene_biotype),]
  attr_names <- tmp_attr[grep(output_org,tmp_attr$name),"name"]
  tmp_orthos <- getBM(attributes = c("ensembl_gene_id","external_gene_name",attr_names), filters = "ensembl_gene_id",values = tmp_genes$ensembl_gene_id, mart = tmp_mart)
  
  if(one2one == TRUE){
  tmp_orthos <- tmp_orthos[grep("ortholog_one2one",tmp_orthos[,paste(output_org,"_homolog_orthology_type",sep = "")]),]
  }

  if(one2one == FALSE){
    tmp_orthos <- tmp_orthos
  }
  
  tmp_orthos

}

#' get Gene Orthologs
#' 
#' Get the one-to-one ortholog for a specific gene between a given species and a desired species 
#' 
#' @import biomaRt
#' @param input_org Species you are starting from. This should be in the latin name format. i.e. Human, Homo Sapien should be "hsapiens"
#' @param output_org Species you want to know the orthologs in. Same format as input_org.  
#' @param gene Ensembl ID of gene in the starting species. 
#' @return data frame with all one-to-one orthologs between specified species 
#' @export
getGeneOrthos <- function(input_org,output_org,gene) {
  tmp_input <- paste(input_org,"_gene_ensembl",sep = "")
  tmp_mart <- useMart("ensembl", dataset = tmp_input) 
  tmp_attr <- listAttributes(tmp_mart)
  attr_names <- tmp_attr[grep(output_org,tmp_attr$name),"name"]
  tmp_orthos <- getBM(attributes = c("ensembl_gene_id","external_gene_name",attr_names), filters = "ensembl_gene_id",values = gene, mart = tmp_mart)
}

