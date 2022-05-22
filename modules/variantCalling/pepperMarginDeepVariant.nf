
process pepperMarginDeepVariant {
  maxForks 1
  accelerator params.gpus 
  container 'docker://kishwars/pepper_deepvariant:r0.8' + (params.gpus > 0 ? '-gpu': '')
  publishDir params.publishDir, mode: 'copy'

  input:
    path('input.bam')
    path('input.bam.bai')
    path('reference.fasta')
    path('reference.fasta.fai')

  output:
    path('pepper')

  script: 
    if(params.gpus > 0)
      """
        run_pepper_margin_deepvariant call_variant \
          --ont_r9_guppy5_su                       \
          --gpu                                    \
          --threads ${params.threads}              \
          --bam input.bam                          \
          --fasta reference.fasta                  \
          --output_dir ./pepper
      """
    else 
      """
        run_pepper_margin_deepvariant call_variant \
          --ont_r9_guppy5_su                       \
          --threads ${params.threads}              \
          --bam input.bam                          \
          --fasta reference.fasta                  \
          --output_dir ./pepper
      """
}