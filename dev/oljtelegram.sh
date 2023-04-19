curl -s $OLJ_JOB_URL | grep -oP $OLJ_JOB_URL_PATTERN > joburl.txt && md5sum joburl.txt > "currenthashed.txt" && \
if cmp --silent -- "currenthashed.txt" "hashed_jobs/hashed.txt"; then
  echo "Files contents are identical. Ignoring..."
else
  echo "Updating contents" && rm "hashed_jobs/hashed.txt" && cp currenthashed.txt "hashed_jobs/hashed.txt" && CURRENT_URL=$(head -n1 joburl.txt) && echo $CURRENT_URL && curl -X POST $TELEGRAM_API -d "${TELEGRAM_MESSAGE} ${CURRENT_URL}" && git add hashed_jobs && git commit -m "Updating hashed" && git push
fi
