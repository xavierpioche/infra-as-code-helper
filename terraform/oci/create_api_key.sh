APIKEY="oci-tf"
mkdir ${HOME}/.oci
openssl genrsa -out ${HOME}/.oci/${APIKEY}_private.pem 2048
openssl rsa -pubout -in ${HOME}/.oci/{APIKEY}_private.pem -out ${HOME}/.oci/{APIKEY}_public.pem
cat ${APIKEY}_public.pem
