#################################################
#      Step 1. Download Raw Data From NCBI      #
#################################################

# download Drosophia Sechellia data collected from Taiwan
# (note) 
target_path=sechellia.taiwan
mkdir $target_path
for num in {1952772..1952778}
do
  echo "download $target_path/SRR$num"
  wget -P ./$target_path ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP056/SRP056883/SRR$num/SRR$num.sra
done

# download Drosophia Sechellia data collected from Japan
target_path=sechellia.japan
mkdir $target_path
for num in {1973486..1973491}
do
  echo "download $target_path/SRR$num"
  wget -P ./$target_path ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP057/SRP057153/SRR$num/SRR$num.sra
done

# download Drosophia Sechellia data collected from Taiwan
target_path=simulans.japan
mkdir $target_path
for num in {1973492..1973497}
do
  echo "download $target_path/SRR$num"
  wget -P ./$target_path ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP057/SRP057154/SRR$num/SRR$num.sra
done

######################################################## 
#   Step 2. Convert raw data from SRA format to        #
#           paired-end FASTQ format using sratoolkit   #
########################################################

# Download sratoolkit v2.8.1 (Ubuntu Linux 64 bit architecture)
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.1/sratoolkit.2.8.1-ubuntu64.tar.gz
tar zxvf sratoolkit.2.8.1-ubuntu64.tar.gz
rm sratoolkit.2.8.1-ubuntu64.tar.gz
mv sratoolkit.2.8.1-ubuntu64 sratoolkit.2.8.1

for target in sechellia.taiwan sechellia.japan simulans.japan
do
  for file in `ls $target`
  do
    echo "processing $target/$file"
      ./sratoolkit.2.8.1/bin/fastq-dump --split-3 ./$target/$file
  done
  mv *.fastq ./$target/.
done
