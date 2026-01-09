# Mapping early PRC2 nucleation sites upon Suz12 reintroduction reveals features of de novo Polycomb recruitment

Itzel Alejandra Hernández-Romero, Carlos Alberto Peralta-Alvarez, Abraham Román-Figueroa, .., David Valle-Garcia et. al. 

Corresponding: Victor Julian Valdes

## Abstract
Polycomb domains safeguard cell identity by maintaining lineage-specific chromatin states enriched in repressive histone modifications, preserving the epigenetic memory of cell lineages. While Polycomb Repressive Complex 2 (PRC2) can re-establish its occupancy after perturbation, the mechanisms that guide de novo Polycomb recruitment remain unclear. To address this, we engineered an auxin-inducible degradation system to reversibly deplete and reintroduce the endogenous PRC2 core subunit Suz12 in mouse embryonic stem cells (mESCs). Genome-wide profiling at an early recovery time point revealed ~1,100 PRC2 nucleation sites, characterized by rapid Suz12 and histone H3K27me3 re-accumulation with strong signal, with minimal impact on gene expression. These sites were significantly enriched at bivalent promoters, coinciding with unmethylated CpG islands and chromatin states associated with developmental regulation, and were largely conserved in differentiated cells. Motif analysis identified G/C-rich DNA sequences associated with E2F and zinc-finger proteins, alongside strong co-occupancy with MTF2 and JARID2, two PRC2 cofactors previously implicated in Polycomb targeting. Notably, a subset of nucleation sites overlapped with long-range chromatin interaction anchors in histone H3K27me3 HiChIP datasets. These findings reveal that PRC2 de novo nucleation sites are associated with a combination of chromatin states, DNA sequence features, cofactor co-occupancy and spatial genome organization, suggesting that epigenetic memory can be re-established through defined genomic and chromatin features.

## Introduction

This repository contains code used to analyze data presented as results on our preprint available on bioRxiv (https://www.biorxiv.org/content/10.1101/2025.09.02.673664v1).

Please contact us if you require assitance with the code. :)

## Content 

Code is organized on thematic directories by experimental approach.

| Directory | Description | Script owner |
|-----------|--:|:-:|
| RNA-seq| Code for Differential gene expression analysis| Carlos Peralta-Alvarez|
| ChIP-seq | Code for ChIP-Seq data analysis | Carlos Peralta-Alvarez| 
| HiChIP | Code for HiChIP analysis| Abraham Román-Figueroa | 
| CpG analysis| Code for Random distribution analysis and CpG methylation and CG percentage | David Valle-Garcia | 

## Raw sequencing dataset

Our raw sequencing dataset can be found at GEO database with accession numbers: ChIP-seq GSE305054 and RNA-seq GSE305055.

Other publicly available data used for analysis were found at GEO database with accession numbers: thymocytes GSM1498452, intestinal epithelium GSM3020554, neural progenitors GSM878558, H3K4me3 GSM6261533, H3K9ac GSM8107956, H3K27ac GSE280487, Mtf2 GSM6585902, Jarid2 GSM6585904, R-loops GSM1720620, HiChIP-seq GSE150907,and DNA methylation GSE266926.
