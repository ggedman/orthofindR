#' get Orthologs 
#' 
#' Get all one-to-one orthologs between a given species and a desired species 
#' 
#' @param input_org Species you are starting from. This should be in the latin name format. i.e. Human, Homo Sapien should be "hsapiens"
#' @param comp_org Species you want to know the orthologs in. Same format as input_org.  
#' @return data frame with all one-to-one orthologs between specified species 
#' 
getOrthos <- function(input_org,comp_org) {
  tmp_input <- paste(input_org,"_gene_ensembl",sep = "")
  tmp_mart <- useMart("ensembl", dataset = tmp_input) 
  tmp_genes <- getBM(attributes = c("ensembl_gene_id", "gene_biotype"), mart = tmp_mart)
  tmp_genes <- tmp_genes[grep("protein_coding",tmp_genes$gene_biotype),]
  tmp_orthos <- getBM(attributes = c("ensembl_gene_id","external_gene_name",paste(comp_org,"_homolog_ensembl_gene",sep=""),paste(comp_org,"_homolog_associated_gene_name",sep = ""),paste(comp_org,"_homolog_orthology_type",sep = "")), filters = "ensembl_gene_id",values = tmp_genes$ensembl_gene_id, mart = tmp_mart)
  orthos_one2one <- tmp_orthos[grep("ortholog_one2one",tmp_orthos[,5]),]
}

#' get Gene Orthologs
#' 
#' Get the one-to-one ortholog for a specific gene between a given species and a desired species 
#' 
#' @param input_org Species you are starting from. This should be in the latin name format. i.e. Human, Homo Sapien should be "hsapiens"
#' @param comp_org Species you want to know the orthologs in. Same format as input_org.  
#' @param gene Ensembl ID of gene in the starting species. 
#' @return data frame with all one-to-one orthologs between specified species 
#' 
getGeneOrthos <- function(input_org,comp_org,gene) {
  tmp_input <- paste(input_org,"_gene_ensembl",sep = "")
  tmp_mart <- useMart("ensembl", dataset = tmp_input) 
  tmp_orthos <- getBM(attributes = c("ensembl_gene_id","external_gene_name",paste(comp_org,"_homolog_ensembl_gene",sep=""),paste(comp_org,"_homolog_associated_gene_name",sep = ""),paste(comp_org,"_homolog_orthology_type",sep = "")), filters = "ensembl_gene_id",values = gene, mart = tmp_mart)
}

