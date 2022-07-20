#!/bin/bash

setupDirs(){
  mkdir "data"
  mkdir "data"/"humanGenome" && mkdir "data"/"covid"
}

downloadHumanGenome(){

  for i in {1..22}
    do
      echo $i
        wget "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr"$1".fa.gz" -P .data/humanGenome
        extract "$i"
    done
}

downloadCovid(){

  wget "https://storage.googleapis.com/nih-sequence-read-archive/sra-src/SRR12412952/SP-2_R1.fastq.1" -P ./data/covid/
  wget "https://storage.googleapis.com/nih-sequence-read-archive/sra-src/SRR12412952/SP-2_R2.fastq.1" -P ./data/covid/
  mv ./data/covid/SP-2_R1.fastq.1 ./data/covid/SP-1_R2.fastq
  mv ./data/covid/SP-2_R2.fastq.1 ./data/covid/SP-2_R2.fastq
  #wget "https://files.ca-1.osf.io/v1/resources/jt2n5/providers/osfstorage/5ede595708aad3013143c7f3?action=download&direct&version=3" -P ./data/covid/
}

extract(){
  gzip -d "./data/humanGenome/chr"$1".fa.gz"
}

setupNanosim(){

    git submodule init
    git submodule update
    cp fixed_requirements.txt ./NanoSim/requirements.txt
    # Solution for this ??
    #cd NanoSim %% conda create --name nanosim python=3.7
    #conda activate nanosim
    #conda install --file requirements.txt -c conda-forge -c bioconda
    #cd ..
}

setupDirs
#downloadHumanGenome
downloadCovid
setupNanosim
